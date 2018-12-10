

package com.drakelee.demo.database.configuration;

import com.base.components.database.configuration.JpaConfiguration;
import com.base.components.database.dao.base.GenericJpaDaoImpl;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * JPA Configuration
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-11-21 11:30
 */
@Configuration
@EnableTransactionManagement
@EntityScan("com.drakelee.demo.common.domain")
@EnableJpaRepositories(
  value = "com.drakelee.demo.database.dao",
  repositoryBaseClass = GenericJpaDaoImpl.class
)
public class DatabaseConfiguration extends JpaConfiguration {
}
