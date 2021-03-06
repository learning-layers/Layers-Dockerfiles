<%--
  ~ Password Management Servlets (PWM)
  ~ http://code.google.com/p/pwm/
  ~
  ~ Copyright (c) 2006-2009 Novell, Inc.
  ~ Copyright (c) 2009-2012 The PWM Project
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or
  ~ (at your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful,
  ~ but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~ GNU General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  --%>

<!DOCTYPE html>
<%@ page language="java" session="true" isThreadSafe="true"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="pwm" prefix="pwm" %>
<html dir="<pwm:LocaleOrientation/>">
<%@ include file="/WEB-INF/jsp/fragment/header.jsp" %>
<body class="nihilo" onload="pwmPageLoadHandler();">
<div id="wrapper">
    <jsp:include page="/WEB-INF/jsp/fragment/header-body.jsp">
        <jsp:param name="pwm.PageName" value="Status"/>
    </jsp:include>
    <div id="centerbody">
        <%@ include file="admin-nav.jsp" %>
        <div data-dojo-type="dijit.layout.ContentPane" title="Health">
            <div id="healthBody">
                <div id="WaitDialogBlank"></div>
            </div>
            <script type="text/javascript">
                PWM_GLOBAL['startupFunctions'].push(function(){
                require(["dojo/domReady!"],function(){
                    showPwmHealth('healthBody', {showRefresh:true});
                });
                });
            </script>
            <br/>
            <div style="width: 100%; font-size: smaller; font-style: italic; text-align: center">
                public health page at
                <a href="<%=request.getContextPath()%>/public/health.jsp"><%=request.getContextPath()%>/public/health.jsp</a>
                , this content is dynamically refreshed
            </div>
        </div>
    </div>
    <div class="push"></div>
</div>
<script type="text/javascript">
    function startupPage() {
        require(["dojo/parser","dojo/domReady!","dijit/layout/TabContainer","dijit/layout/ContentPane","dijit/Dialog"],function(dojoParser){
            dojoParser.parse();

            showStatChart('PASSWORD_CHANGES',14,'statsChart');
            setInterval(function(){
                showStatChart('PASSWORD_CHANGES',14,'statsChart');
            }, 61 * 1000);
        });
    }
    PWM_GLOBAL['startupFunctions'].push(function(){
        startupPage();
    });
</script>
<%@ include file="/WEB-INF/jsp/fragment/footer.jsp" %>
</body>
</html>


