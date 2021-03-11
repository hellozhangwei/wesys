# moqui-zsys

Install moqui framework and mantle artifacts

1. git clone https://github.com/moqui/moqui-framework.git
2. cd moqui-framwork
3. gradlew getComponentSet -PcomponentSet=demo
4. Change def elasticSearchVersion = '7.4.2' to def elasticSearchVersion = '7.8.0' in build.gralde in line 28
6. gradlew downloadElasticSearch
7. Download elasticsearch-analysis-ik-7.8.0 from https://github.com/medcl/elasticsearch-analysis-ik/releases/tag/v7.8.0
   to moqui-framework/runtime/elasticsearch/plugins
8. Create elasticsearch user
9. Add
   ```java
   if("text".equals(mappingType)) {
      propertyMap.put("analyzer", "ik_max_word")
      propertyMap.put("search_analyzer", "ik_max_word")
   }
   ````
   
   to line 822 in moqui-framework/framework/src/main/groovy/org/moqui/impl/context/ElasticFacadeImpl.groovy
10. gradlew run
11. Open http://localhost:8080/qapps

Install wesys and moqui-zapps

1. cd moqui-framework/runtime/component
2. git clone https://github.com/zhangwei1979/moqui-zapps.git
3. git clone https://github.com/zhangwei1979/wesys.git
4. gradlew load
5. gradlew run
6. Open http://localhost:8080/zapps

Create elasticsearch user for Linux

* adduser elasticsearch
* passwd elasticsearch
* chown -R elasticsearch:elasticsearch elasticsearch-7.8.0
* edit config/jvm.options and set Xms and Xmx
* su elasticsearch
* ./elasticsearch -d

