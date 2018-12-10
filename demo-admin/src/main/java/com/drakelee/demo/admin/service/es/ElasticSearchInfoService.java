

package com.drakelee.demo.admin.service.es;

import com.base.components.common.dto.page.DataPage;
import com.base.components.common.elasticsearch.DocumentIndexBuildQuery;
import com.base.components.common.elasticsearch.EsIndex;
import com.base.components.common.util.JsonUtils;
import com.base.components.elasticsearch.repository.base.GenericElasticsearchRepository;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.lang.reflect.Field;
import java.util.Collections;
import java.util.List;

/**
 * ElasticSearchInfoService
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-01-04 14:25
 */
@Service
@ConditionalOnProperty(value = "base.elasticsearch.enable", havingValue = "true")
public class ElasticSearchInfoService {
  @Autowired
  private List<GenericElasticsearchRepository> repositoryList;
  @PersistenceContext
  private EntityManager entityManager;
  @Autowired
  private EsIndex esIndex;

  public List<ObjectNode> infoList(){
    List<ObjectNode> array = Collections.emptyList();
    if(repositoryList != null && !repositoryList.isEmpty()){
      array = Lists.newArrayList();
      for (GenericElasticsearchRepository repository : repositoryList) {
        Class entityClass = repository.getEntityClass();
        ObjectNode node = JsonUtils.mapper.createObjectNode().put("entityClass", entityClass.getName());
        addDocumentInfo(entityClass, node);
        addDocumentBuilderInfo(entityClass, node);
        node.put("docsCount", repository.count());
        array.add(node);
      }
    }
    return array;
  }

  public long rebuild(String indexName, String type){
    if(StringUtils.isNotBlank(indexName) && StringUtils.isNotBlank(type)){
      for (GenericElasticsearchRepository repository : repositoryList) {
        Class<?> entityClass = repository.getEntityClass();
        Document doc = entityClass.getAnnotation(Document.class);
        if(doc != null && indexName(doc).equals(indexName)){
          if("soft".equalsIgnoreCase(type)){
            return repository.rebuildIndexWithIncrement();
          }
          else if("mixed".equalsIgnoreCase(type)){
            return repository.rebuildIndexWithNotPersistent();
          }
          else if("hard".equalsIgnoreCase(type)){
            return repository.rebuildIndexWithAll();
          }
        }
      }
    }
    return 0L;
  }

  public List<ObjectNode> getFields(String indexName){
    List<ObjectNode> fields = Lists.newArrayList();
    if(StringUtils.isNotBlank(indexName)){
      for (GenericElasticsearchRepository repository : repositoryList) {
        Class<?> entityClass = repository.getEntityClass();
        Document doc = entityClass.getAnnotation(Document.class);
        if(doc != null && indexName(doc).equals(indexName)){
          fields.add(JsonUtils.mapper.createObjectNode()
                                     .put("title", repository.getIdAttribute())
                                     .put("field", repository.getIdAttribute()));
          for (Field field : entityClass.getDeclaredFields()) {
            if(field.getAnnotation(org.springframework.data.elasticsearch.annotations.Field.class) != null){
              fields.add(JsonUtils.mapper.createObjectNode()
                                         .put("title", field.getName())
                                         .put("field", field.getName()));
            }
          }
          break;
        }
      }
    }
    return fields;
  }

  public Page fullTextSearch(String indexName, String query, String split, Pageable pageable){
    if(StringUtils.isNotBlank(indexName)){
      for (GenericElasticsearchRepository repository : repositoryList) {
        Class<?> entityClass = repository.getEntityClass();
        Document doc = entityClass.getAnnotation(Document.class);
        if(doc != null && indexName(doc).equals(indexName)){
          return repository.fullTextSearch(query, split, pageable);
        }
      }
    }
    return DataPage.getEmptyPage();
  }


  private void addDocumentInfo(Class<?> entityClass, ObjectNode node){
    Document doc = entityClass.getAnnotation(Document.class);
    if(doc != null){
      node.put("indexName", indexName(doc));
      node.put("indexType", doc.type());
      node.put("shards", doc.shards());
      node.put("replicas", doc.replicas());
    }
  }

  private void addDocumentBuilderInfo(Class<?> entityClass, ObjectNode node){
    DocumentIndexBuildQuery docBuilder = entityClass.getAnnotation(DocumentIndexBuildQuery.class);
    if(docBuilder != null){
      node.put("buildSql", docBuilder.value());
      node.put("buildIdColumn", docBuilder.idColumn());
      node.put("buildColumnPrefix", docBuilder.columnPrefix());
      node.putPOJO("dbCount", entityManager.createNativeQuery(
        "select count(1) from ("+ docBuilder.value() + ") t").getSingleResult());
    }
  }

  private String indexName(Document document){
    return document.indexName()
                   .replace(EsIndex.PROJECT_NAME_PLACEHOLDER, esIndex.getProjectName())
                   .replace(EsIndex.INDEX_PROFILE_PLACEHOLDER, esIndex.getIndexProfile());
  }
}
