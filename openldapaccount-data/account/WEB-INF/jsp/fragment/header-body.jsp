<%@ page import="password.pwm.ContextManager" %>
<%@ page import="password.pwm.PwmApplication" %>
<%@ page import="password.pwm.PwmConstants" %>
<%@ page import="password.pwm.PwmSession" %>
<%@ page import="password.pwm.config.PwmSetting" %>
<%@ page import="password.pwm.error.PwmUnrecoverableException" %>
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

<%--
  ~ This file is imported by most JSPs, it shows the main 'header' in the html
  - which by default is a blue-gray gradieted and rounded block.
  --%>
<%@ taglib uri="pwm" prefix="pwm" %>
<%
    PwmSession pwmSessionHeaderBody = null;
    PwmApplication pwmApplictionHeaderBody = null;
    try {
        pwmApplictionHeaderBody = ContextManager.getPwmApplication(session);
        pwmSessionHeaderBody = PwmSession.getPwmSession(session);
    } catch (PwmUnrecoverableException e) {
        /* application must be unavailable */
    }
%>
<% final boolean loggedIn = pwmSessionHeaderBody != null && pwmSessionHeaderBody.getSessionStateBean().isAuthenticated();%>
<% final boolean showLogout = loggedIn && pwmApplictionHeaderBody != null && pwmApplictionHeaderBody.getConfig().readSettingAsBoolean(PwmSetting.DISPLAY_LOGOUT_BUTTON); %>
<% final boolean showHome =  loggedIn && pwmApplictionHeaderBody != null && pwmApplictionHeaderBody.getConfig().readSettingAsBoolean(PwmSetting.DISPLAY_HOME_BUTTON); %>
<% final String customImageLogoUrl = pwmApplictionHeaderBody.getConfig().readSettingAsString(PwmSetting.DISPLAY_CUSTOM_LOGO_IMAGE); %>
<% final boolean showConfigHeader = !request.getRequestURI().contains("configmanager") && pwmApplictionHeaderBody != null && pwmApplictionHeaderBody.getApplicationMode() == PwmApplication.MODE.CONFIGURATION; %>
<% if (showConfigHeader) { %>
<div id="header-warning">
    <% final String configManagerUrl = request.getContextPath() + "/config/ConfigManager"; %>
    <pwm:Display key="Header_ConfigModeActive" bundle="Admin" value1="<%=PwmConstants.PWM_APP_NAME%>" value2="<%=configManagerUrl%>"/> &nbsp;&nbsp; <a href="#" style="font-size: 70%" onclick="getObject('header-warning').style.display='none'">hide</a>
</div>
<% } %>
<nav  class="navbar navbar-fixed-top">
    <div class="navbar-inner">
		<div class="container">
			<a id="header-company-logo" class="brand" href="<%=request.getContextPath()%>"><img id="header-company-logo-image" src=" <%=customImageLogoUrl%>">Learning Layers PWM</a>
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-responsive-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			
			<div class="nav-collapse navbar-responsive-collapse collapse">
				<ul class="nav navbar-nav">
					<li id="homebuttonDiv"> <a id="HomeButton" href="<%=request.getContextPath()%>">Home</a></li>
					<li <%if(loggedIn){ %> style='display:none' <% }%>> <a href="<%=request.getContextPath()%><pwm:url url='/private/Login' />">Login</a></li>
					<li <%if(!loggedIn){ %> style='display:none' <% }%> id="updateNav">
						<a  href = "<%=request.getContextPath()%><pwm:url url='/private/UpdateProfile' />">Update Profile</a>
					</li>
					<li <%if(!loggedIn){ %> style='display:none' <% }%> id="logoutDiv">
						<a id="LogoutButton" href="<%=request.getContextPath()%><pwm:url url='/public/Logout'/>">Logout</a>
					</li>
				</ul>
			</div>
        </div>
    </div>
	<div id="header-right-logo" style="position: absolute">
    </div>
	<div id="header-title"></div>
</nav>

