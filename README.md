# Install JDK 11
https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz

# Install moqui framework and mantle artifacts

1. git clone https://github.com/moqui/moqui-framework.git
2. cd moqui-framwork
3. gradlew getComponentSet -PcomponentSet=demo
4. gradlew downloadElasticSearch
5. Install elasticsearch-analysis-ik-7.10.2.0 
   
   a) Download https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.10.2/elasticsearch-analysis-ik-7.10.2.zip
      
   b) mkdir moqui-framework/runtime/elasticsearch/plugins

   c) unzip elasticsearch-analysis-ik-7.10.2.zip -d elasticsearch-analysis-ik-7.10.2
   
   d) mv elasticsearch-analysis-ik-7.10.2 moqui-framework/runtime/elasticsearch/plugins

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

# Install wesys and moqui-zapps

1. cd moqui-framework/runtime/component
2. git clone https://github.com/zhangwei1979/moqui-zapps.git
3. git clone https://github.com/zhangwei1979/wesys.git
4. git clone https://github.com/zhangwei1979/moqui-login.git
5. git clone https://github.com/shendepu/moqui-captcha.git
6. gradlew load
7. gradlew run
8. Open http://localhost:8080/zapps

Create elasticsearch user for Linux

* adduser elasticsearch
* passwd elasticsearch
* chown -R elasticsearch:elasticsearch moqui-framework/runtime/elasticsearch
* edit moqui-framework/runtime/elasticsearch/config/jvm.options and set Xms and Xmx
* su elasticsearch
* ./elasticsearch -d

Install kibana
https://artifacts.elastic.co/downloads/kibana/kibana-oss-7.10.2-darwin-x86_64.tar.gz

#Deployment in Docker
1. apt install unzip
2. Install JDK
3. git clone https://github.com/moqui/moqui-framework.git
4. cd moqui-framework
5. ./gradlew getRuntime
6. ./gradlew getComponent -Pcomponent=PopCommerce
7. ./gradlew getComponent -Pcomponent=moqui-hazelcast
8. ./gradlew getComponent -Pcomponent=example
9. ./gradlew getComponent -Pcomponent=moqui-zh_CN-addon
10. ./gradlew downloadElasticsearch
11. git clone https://github.com/zhangwei1979/wesys.git
12. git clone https://github.com/zhangwei1979/moqui-zapps.git
13. git clone https://github.com/zhangwei1979/moqui-login.git
14. git clone https://github.com/shendepu/moqui-captcha.git
15. groupadd -r elasticsearch
16. useradd --no-log-init -r -d /opt/moqui-framework/runtime/elasticsearch -g elasticsearch elasticsearch
17. chown -R elasticsearch:elasticsearch /opt/moqui-framework/runtime/elasticsearch
18. ./gradlew addRuntime 
19. ./docker/simple/docker-build.sh
