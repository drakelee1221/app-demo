

package com.drakelee.demo.elasticsearch.configuration;

import com.base.components.elasticsearch.configuration.BaseElasticSearchConfig;
import com.base.components.elasticsearch.repository.base.impl.GenericElasticsearchRepositoryImpl;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;

@Configuration
@ConditionalOnProperty(value = "base.elasticsearch.enable", havingValue = "true")
@EnableElasticsearchRepositories(value = "com.drakelee.demo.elasticsearch.repository",
  repositoryBaseClass = GenericElasticsearchRepositoryImpl.class)
@AutoConfigureBefore(BaseElasticSearchConfig.class)
public class ElasticSearchConfig {
}
