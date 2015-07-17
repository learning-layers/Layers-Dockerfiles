#Tethys-UserStorage-Dockerfile

####Project Description

This Dockerfiles deploys the UserStorage webapplication of our Tethys. You can find the Project here: https://github.com/learning-layers/Tethys-UserStorage
It can store & retrieve files through a user-friendly REST-API and can be tested and explored with Swagger.
Also need to be configurated to use different Storage Types:
Local Storage
Swift Storage
It also needs be configurated to work with OpenID Connect or the service can be mocked for test cases or single user mode

You can start it like this:
docker run -it -p 8081:8080 -e TUS_PASS=pass -e ADAPTER_URL_SWIFT=192.168.0.41 -e SWIFT_TENANT=tenant -e SWIFT_USER=user -e SWIFT_KEY=key <Tethys-UserStorage-Image-Name>

#### ENV of this Image and his base image

|ENV variable|value|absolute value|  
|---|---|---|  
|INSTALL_DIR|/opt|/opt|  
|INIT_SH=|${INSTALL_DIR}/init.sh|/opt/init.sh|  
|INIT_DIR|${INSTALL_DIR}/init"|/opt/init|  
|JAVA_HOME|/usr/lib/jvm/java-8-oracle|/usr/lib/jvm/java-8-oracle|  
|TOMCAT_HOME|${INSTALL_DIR}/tomcat|/opt/tomcat|  
|TUS|${TOMCAT_HOME}/webapps/TethysUserStorage|/opt/tomcat/webapps/TethysUserStorage|  
|TUS_WAR|${TOMCAT_HOME}/webapps/TethysUserStorage.war|/opt/tomcat/webapps/TethysUserStorage.war|

#### ENV you need to specify for this image to work

|ENV variable|example|dependency|  
|---|---|---|  
|STORAGE_TYPE|Local
||Swift
|AUTH_TYPE|MockOIDC|
||OIDC
|TUS_PASS|awesomepassword|
|ADAPTER_URL_SWIFT|http://$ADAPTER_IP:80/swift|STORAGE_TYPE=Swift
|SWIFT_TENANT|tenant|STORAGE_TYPE=Swift
|SWIFT_USER|user|STORAGE_TYPE=Swift
|SWIFT_KEY|key|STORAGE_TYPE=Swift
|ADAPTER_URL_OIDC|http://$ADAPTER_IP:80/"|AUTH_TYPE=OIDC
#### ENV I need to implement to get other things working:

|ENV variable|example|dependency|  
|---|---|---|  
|LOCAL_PATH|/opt/data|STORAGE_TYPE=Local
|OIDC_AUTH_TOKEN|test|AUTH_TYPE=MockOIDC
|OIDC_ADMIN_TOKEN|test|AUTH_TYPE=MockOIDC
