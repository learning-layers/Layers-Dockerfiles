FROM learninglayers/tomcat
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>
 
ADD account/ $TOMCAT_HOME/webapps 
RUN chmod 766 -R /opt 
ENV PWMCONF /opt/conf

CMD sed -i "s#LDAP_DC#${LDAP_DC}#g" $PWMCONF/PwmConfiguration.xml \
    && sed -i "s#PWM_LDAP_ADMINS#${PWM_LDAP_ADMINS}#g" $PWMCONF/PwmConfiguration.xml \
    && cp $PWMCONF/PwmConfiguration.xml $TOMCAT_HOME/webapps/WEB-INF \
    && . /opt/init.sh

# RUN cp /opt/conf/PwmConfiguration.xml $TOMCAT_HOME/webapps/WEB-INF

# ENTRYPOINT ["$TOMCAT_HOME/webapps/index.jsp"]
