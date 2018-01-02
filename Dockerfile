FROM maven:3.5-jdk-8-slim

MAINTAINER szss
#设置时区
ENV TZ Asia/Shanghai

EXPOSE 8899

ENV VERSION 2.1.5

ENV CONSOLE_PATH elastic-job-lite-${VERSION}/elastic-job-lite/elastic-job-lite-console

# 设置maven仓库
RUN rm -rf /usr/share/maven/conf/settings.xml \
    && echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?> \n\
<settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\" \n\
          xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n\
          xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd\"> \n\
    <mirrors> \n\
        <mirror> \n\
            <id>nexus-aliyun</id> \n\
            <mirrorOf>central</mirrorOf> \n\
            <name>Nexus Aliyun</name> \n\
            <url>http://maven.aliyun.com/nexus/content/groups/public</url> \n\
        </mirror> \n\
    </mirrors> \n\
</settings> \n\
" >> /usr/share/maven/conf/settings.xml \
    && apt-get update \
# 安装weget
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
# 下载源码压缩包
    && wget https://github.com/elasticjob/elastic-job-lite/archive/${VERSION}.tar.gz \
# 解压
    && tar -zxvf ${VERSION}.tar.gz \
# 删除源码压缩包
    && rm -rf ${VERSION}.tar.gz \
# mvn打包
    && mvn package -DskipTests -f ${CONSOLE_PATH}/pom.xml \
# 复制console包
    && mv ${CONSOLE_PATH}/target/elastic-job-lite-console-${VERSION}.tar.gz /elastic-job-lite-console-${VERSION}.tar.gz \
# 删除源码解压文件夹
    && rm -rf elastic-job-lite-${VERSION} \
# 解压console
    && tar -zxvf /elastic-job-lite-console-${VERSION}.tar.gz

ENTRYPOINT elastic-job-lite-console-${VERSION}/bin/start.sh
