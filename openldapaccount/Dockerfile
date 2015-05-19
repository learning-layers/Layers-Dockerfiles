FROM learninglayers/tomcat
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>
 
RUN chmod 766 -R /opt 

#ADD account/ $TOMCAT_HOME/webapps # -> Device or resource busy
ENV PWMCONF /opt/conf
ENV PWMACC /opt/account

CMD cp -fR $PWMACC $TOMCAT_HOME/webapps \
    && cp -fR $PWMCONF $TOMCAT_HOME/webapps \
    && sed -i "s#LDAP_DC#${LDAP_DC}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#PWM_LDAP_ADMINS#${PWM_LDAP_ADMINS}#g" $PWMCONF/PwmConfiguration.xml \
    && cp $PWMCONF/PwmConfiguration.xml $TOMCAT_HOME/account/webapps/WEB-INF \
    && . /opt/init.sh
