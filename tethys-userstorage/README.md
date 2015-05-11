#Tethys-UserStorage-Dockerfile

This Dockerfiles deploys the UserStorage webapplication of our Tethys. You can find the Project here: https://github.com/learning-layers/Tethys-UserStorage
It can store & retrieve files through a user-friendly REST-API and can be tested and explored with Swagger.
Also need to be configurated to use different Storage Types:
Local Storage
Swift Storage
It also needs be configurated to work with OpenID Connect or the service can be mocked for test cases or single user mode

You can start it like this:
docker run -it -p 8081:8080 -e TUS_PASS=pass -e ADAPTER_URL_SWIFT=192.168.0.41 -e SWIFT_TENANT=tenant -e SWIFT_USER=user -e SWIFT_KEY=key <Tethys-UserStorage-Image-Name>
