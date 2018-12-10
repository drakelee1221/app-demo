

package com.drakelee.demo.elasticsearch.repository.demo;

import com.base.components.elasticsearch.repository.base.GenericElasticsearchRepository;
import com.drakelee.demo.common.domain.demo.Demo;
import org.springframework.stereotype.Repository;

/**
 * test
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-10 9:57
 */
@Repository
public interface DemoEsRepository extends GenericElasticsearchRepository<Demo, String> {

}
