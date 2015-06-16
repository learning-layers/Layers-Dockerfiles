FROM learninglayers/tomcat:7
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>
 
RUN chmod 766 -R /opt 

#ADD account/ $TOMCAT_HOME/webapps # -> Device or resource busy
ENV PWMCONF /opt/conf
ENV PWMACC /opt/account

CMD cp -fR $PWMACC $TOMCAT_HOME/webapps \
    && cp -fR $PWMCONF $TOMCAT_HOME/webapps \
    && sed -i "s#LAYERS_API_URI#${LAYERS_API_URI}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#LDAP_ROOT_DN#${LDAP_ROOT_DN}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#LDAP_ROOT_USER#${LDAP_ROOT_USER}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#PWM_LDAP_ADMINS#${PWM_LDAP_ADMINS}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#TETHYS_IP#${TETHYS_IP}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#openldap#${LDAP_URI}#g" $PWMCONF/PwmConfiguration.xml \
    && cp $PWMCONF/PwmConfiguration.xml $TOMCAT_HOME/webapps/account/WEB-INF \
    && . /opt/init.sh
