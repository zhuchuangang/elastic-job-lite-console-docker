
#!/bin/bash
# 修改认证配置文件
sed -i "s/root.username=root/root.username=${ROOT_USERNAME}/g" elastic-job-lite-console-${VERSION}/conf/auth.properties
sed -i "s/root.password=root/root.password=${ROOT_PASSWORD}/g" elastic-job-lite-console-${VERSION}/conf/auth.properties
sed -i "s/guest.username=guest/guest.username=${GUEST_USERNAME}/g" elastic-job-lite-console-${VERSION}/conf/auth.properties
sed -i "s/guest.password=guest/guest.password=${GUEST_PASSWORD}/g" elastic-job-lite-console-${VERSION}/conf/auth.properties

elastic-job-lite-console-${VERSION}/bin/start.sh
