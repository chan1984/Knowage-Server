<%--
Knowage, Open Source Business Intelligence suite
Copyright (C) 2016 Engineering Ingegneria Informatica S.p.A.

Knowage is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

Knowage is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--%>


<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA IMPORTS															--%>
<%-- ---------------------------------------------------------------------- --%>

<%-- <%@page import="it.eng.spagobi.commons.bo.UserProfile"%> --%>
<%@page import="it.eng.spagobi.services.security.bo.SpagoBIUserProfile"%>
<%@page import="java.util.Enumeration"%>
<%@page import="it.eng.spagobi.commons.dao.DAOFactory"%>
<%@page import="it.eng.spagobi.tools.dataset.federation.FederationDefinition"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>



<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA IMPORTS															--%>
<%-- ---------------------------------------------------------------------- --%>
<%@page import="it.eng.spago.configuration.*"%>
<%@page import="it.eng.spago.base.*"%>
<%@page import="it.eng.spagobi.utilities.engines.EngineConstants"%>
<%@page import="it.eng.spagobi.commons.bo.UserProfile"%>
<%@page import="it.eng.spago.security.IEngUserProfile"%>
<%@page import="it.eng.spagobi.commons.constants.SpagoBIConstants"%>
<%@page import="java.util.Locale"%>
<%@page import="it.eng.spagobi.services.common.EnginConf"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="it.eng.spagobi.commons.dao.IRoleDAO"%>


<%@page import="it.eng.spagobi.utilities.engines.rest.ExecutionSession"%>

<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA CODE 																--%>
<%-- ---------------------------------------------------------------------- --%>
<%

	IEngUserProfile profile = (IEngUserProfile)session.getAttribute(IEngUserProfile.ENG_USER_PROFILE);;
	profile.getUserAttributeNames();
	String getUserId = ((UserProfile)profile).getUserId().toString();	
	UserProfile myUserProfile=(UserProfile)profile;
	String[] names=session.getValueNames();
    session.getAttribute("REQUEST_CONTAINER");
    //boolean isAdmin=UserUtilities.isAdministrator(profile);
    boolean isAdmin=UserUtilities.hasAdministratorRole(profile);
    UserUtilities.isAdministrator(profile);
    String admin=isAdmin+"";
    String userNameOwner=(String)myUserProfile.getUserUniqueIdentifier();
	
    boolean isDev=UserUtilities.hasDeveloperRole(profile);
    boolean isUser=UserUtilities.hasUserRole(profile);
    
	boolean adminView=false,userView=false,devView=false;
	if(isAdmin){ adminView=true;}
	if(isDev && !isAdmin){ devView=true;}
	if(isUser && !isDev && !isAdmin){ userView=true; } 


%>


<%@include file="/WEB-INF/jsp/commons/angular/angularResource.jspf"%>

<script type="text/javascript">
	// var isAdminGlobal=<%=admin.toString()%>;
	var isAdminGlobal=<%=adminView%>;
	var isUserGlobal=<%=userView%>;
	var isDevGlobal=<%=devView%>;
	var ownerUserName="<%=userNameOwner.toString()%>";
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="functionsCatalogControllerModule">
<head>

<%@include file="/WEB-INF/jsp/commons/angular/angularImport.jsp"%>

<!-- Styles -->

<link rel="stylesheet" type="text/css" href="<%=urlBuilder.getResourceLink(request, "themes/commons/css/customStyle.css")%>">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/sbi_default/css/FunctionsCatalog/functionsCatalog.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/src/angular_1.4/tools/commons/angular-table/AngularTable.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/src/angular_1.4/tools/functionsCatalog/functionsCatalog.js"></script>

<!-- Codemirror  -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/lib/codemirror.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/theme/eclipse.css">  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/lib/codemirror.js"></script>  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/lib/angular/codemirror/ui-codemirror.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/lib/angular/mathematicaModified.js"></script>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/addon/hint/show-hint.css" />
<script src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/addon/hint/show-hint.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/addon/hint/sql-hint.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/mode/python/python.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/mode/r/r.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/addon/selection/mark-selection.js"></script>
<script src="${pageContext.request.contextPath}/js/lib/angular/codemirror/CodeMirror-master/addon/display/autorefresh.js"></script>

<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/lib/angular/ngWYSIWYG/wysiwyg.min.js")%>"></script>	
<link rel="stylesheet" type="text/css" href="<%=urlBuilder.getResourceLink(request, "js/lib/angular/ngWYSIWYG/editor.min.css")%>"> 





<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Functions Catalog</title>
</head>

<body  ng-controller="functionsCatalogController" class="bodyStyle kn-functionsCatalog" ng-cloak ng-init="userId='<%=getUserId.toString()%>'; isAdmin=<%=adminView%>; ownerUserName='<%=userNameOwner.toString()%>'; isDev=<%=devView%>; isUser=<%=userView%>">  <!-- only one between isAdmin, isDev, isUser is true (see java code)-->
	<%if(includeInfusion){ %> 
            <%@include file="/WEB-INF/jsp/commons/infusion/infusionTemplate.html"%> 
<%} %>
	<angular-list-detail full-screen=true layout="column">
		
		<% 
		String addFunction="";
		if(isAdmin || isDev){
			addFunction="addFunction";
			
		   } 
		%>
		
		
		<list label="Functions"  new-function="<%=addFunction%>" layout-column> 
		
			<md-content layout="column" >
				<div layout-gt-xs="row" layout="column" class="functionsCardContainer">
				
					<md-card  class="functionsCard"  ng-class="{'active':selectedType == functionType.valueCd}" ng-repeat="functionType in functionTypesList" ng-click="functionsList=filterByType(functionType)" ng-style="{'background-image':functionType.valueDescription}" flex>
						<md-card-content>
		          				<span class="md-headline ng-binding" flex="">{{functionType.valueCd}}</span>
                                <span class="md-subhead ng-binding smallGrey" flex="">{{functionType.domainName}}</span>
						</md-card-content>
					
		      		</md-card>
		      		
					<md-card  class="functionsCard image_all" ng-class="{'active':selectedType == 'All'}" ng-click="functionsList=filterByType({valueCd:'All'})" flex> 
						<md-card-content>
		            			<span class="md-headline ng-binding" flex="">{{translate.load("sbi.functionscatalog.all")}}</span>
		            			<span class="md-subhead ng-binding smallGrey" flex="">{{translate.load("sbi.functionscatalog.allmessage")}}</span>
						</md-card-content>

		      		</md-card>
				</div>	
					<div class="md-block functionsChipsContainer" layout="row" layout-align="center center" >
						<md-chips ng-model="searchKeywords" readonly=true class="functionsChips"> 
							<md-chip-template ng-click="chipFilter($chip)" >
							{{$chip}}
							</md-chip-template>
						</md-chips>	
					</div>
					
		    		<angular-table
		    				id="functionsTable" 
							flex=70
							ng-show=true
							ng-model="functionsList"
							columns='[{"label":"Function Name","name":"name"},{"label":"Owner","name":"owner"}]'  
							columns-search='["name","keywords","description","owner"]'
							show-search-bar=true
							highlights-selected-item=true
							speed-menu-option="acSpeedMenu"
							click-function ="leftTableClick(item)"
							selected-item="tableSelectedFunction"
							no-pagination=true					
					>						
					</angular-table>
			</md-content>
    	</list>
    	
    	
       <detail label='shownFunction.name==undefined? "" : shownFunction.name' save-function="saveFunction" 	cancel-function="cancelFunction"
       	disable-cancel-button=false
		disable-save-button=false
		show-save-button="isAdmin || (isDev && shownFunction.owner==ownerUserName)">
       		<md-tabs layout-fill> 
       		
       			<md-tab label='{{translate.load("sbi.functionscatalog.general");}}'>
					<md-card layout-padding layout="column">
						
						<md-input-container class="md-block" >
        					<label>{{translate.load("sbi.functionscatalog.functionname");}}</label>
        					<input ng-model=shownFunction.name ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
      					</md-input-container>
  
  						<md-input-container class="md-block" >
        					<label>{{translate.load("sbi.functionscatalog.label");}}</label>
        					<input ng-model=shownFunction.label ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
      					</md-input-container>    					
      					
      					<md-input-container class="md-block" >
        					<label>{{translate.load("sbi.functionscatalog.owner");}}</label>
        					<input ng-model=shownFunction.owner ng-disabled=true>
      					</md-input-container> 

						<md-input-container class="md-block" >
        					<label>{{translate.load("sbi.functionscatalog.type");}}</label>
        					<md-select ng-model=shownFunction.type ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
              					<md-option ng-repeat="functionType in functionTypesList" value="{{functionType.valueCd}}">
                					{{functionType.valueCd}}
              					</md-option>
           					</md-select>
      					</md-input-container>
      					
      					</br>
        				
        				<md-input-container class="md-block">
        					<label class="customColorLabel">{{translate.load("sbi.functionscatalog.keywords");}}</label>   					
							<md-chips ng-model="shownFunction.keywords" readonly="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))" ></md-chips>
						</md-input-container>
						
          				<label class="customLabel">{{translate.load("sbi.functionscatalog.description");}}</label>
	          			<wysiwyg-edit ng-if="(isAdmin || (isDev && shownFunction.owner==ownerUserName))" content="shownFunction.description"  layout-fill config="editorConfig"></wysiwyg-edit>
	          			<div ng-if="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))" ng-bind-html=shownFunction.description></div> 
			
					</md-card>
				</md-tab>
       		
				<md-tab label='{{translate.load("sbi.functionscatalog.input");}}' >
				
				<!--  Author: Davverna -- Changed structure to card one -->
					<md-card class="noMdError smallInputs">
						<md-toolbar class="md-toolbar-tools secondaryToolbar">
									{{translate.load("sbi.functionscatalog.inputdatasets");}}
									<div flex></div>
									<md-button class="md-secondary" ng-click="input=addInputDataset()" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))">{{translate.load("sbi.functionscatalog.adddataset");}}</md-button> 	
						</md-toolbar>	
						<md-card-content>					
							<md-list>
								<md-list-item ng-if="shownFunction.inputDatasets.length==0" class="messageItem" layout-align="center center">
									&emsp;&emsp;{{translate.load("sbi.functionscatalog.noinputdatasetsrequired");}}
								</md-list-item>
								<md-list-item class="secondary-button-padding" ng-repeat="d in shownFunction.inputDatasets">
						    		<md-input-container class="md-block" flex>
	  									<label>{{translate.load("sbi.functionscatalog.datasetlabel");}}</label>
	  									<md-select ng-model="d.label" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
		    								<md-option ng-repeat="datasetLabel in datasetLabelsList" value="{{datasetLabel}}">
		      								{{datasetLabel}}
		    								</md-option>
	 									</md-select>
									</md-input-container>
									<md-input-container class="md-block" flex ng-if="d.type=='Simple Input'">
		 								<label>{{translate.load("sbi.functionscatalog.inputname");}}</label>  
		 								<input ng-model="d.name" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
									</md-input-container>
									<md-input-container class="md-block" flex ng-if="d.type=='Simple Input'">
		 								<label>{{translate.load("sbi.functionscatalog.inputvalue");}}</label>  
		 								<input ng-model="d.value" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
									</md-input-container>
									<md-button class="md-secondary" ng-click="datasetPreview(d.label)">{{translate.load("sbi.functionscatalog.datasetpreview");}}</md-button>
									<md-icon class="md-secondary" ng-click="output=removeInputDataset(i)" aria-label="Chat" md-font-icon="fa fa-trash" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))"></md-icon>
						  		</md-list-item>
						  	</md-list>
						</md-card-content>
					</md-card>
					
					<md-card class="noMdError smallInputs">
						<md-toolbar class="md-toolbar-tools secondaryToolbar">
									{{translate.load("sbi.functionscatalog.inputvariables");}}
									<div flex></div>
									<md-button class="md-secondary" ng-click="input=addInputVariable()" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))">{{translate.load("sbi.functionscatalog.addinputvariable");}}</md-button> 		
						</md-toolbar>	
						<md-card-content>
							<md-list>
								<md-list-item ng-if="shownFunction.inputVariables.length==0" class="messageItem" layout-align="center center">
									&emsp;&emsp;{{translate.load("sbi.functionscatalog.noinputvariablesrequired");}}
								</md-list-item>
								<md-list-item ng-repeat="v in shownFunction.inputVariables">
									<md-input-container class="md-block" flex>
	           							<label>{{translate.load("sbi.functionscatalog.variablename");}}</label>
	       								<input ng-model="v.name" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	   								</md-input-container>
	   								<md-input-container class="md-block" flex>
	           							<label>{{translate.load("sbi.functionscatalog.variablevalue");}}</label>
	       								<input ng-model="v.value" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	   								</md-input-container>
	  								<md-icon class="md-secondary" md-font-icon="fa fa-trash" ng-click="output=removeInputVariable(i)" aria-hidden="true" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))"></md-icon>
								</md-list-item>
							</md-list>
						</md-card-content>
					</md-card>
					
									
					<md-card class="noMdError smallInputs">
						<md-toolbar class="md-toolbar-tools secondaryToolbar">
									{{translate.load("sbi.functionscatalog.inputFiles");}}
									<div flex></div>
									<md-button class="md-secondary" ng-click="input=addInputFile()" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))">{{translate.load("sbi.functionscatalog.addinputfile");}}</md-button> 		
						</md-toolbar>	
						<md-card-content>
							<md-list>
								<md-list-item ng-if="shownFunction.inputFiles.length==0" class="messageItem" layout-align="center center">
									&emsp;&emsp;{{translate.load("sbi.functionscatalog.noinputfilesrequired");}}
						 
								</md-list-item>
						<!-- 		
								<md-list-item ng-repeat="u in shownFunction.inputFiles">
									<md-input-container class="md-block" flex>
	           							<label>{{translate.load("sbi.functionscatalog.filename");}}</label>
	       								<input ng-model="u.name" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	   								</md-input-container>
	   								<md-input-container class="md-block" flex>
	           							<label>{{translate.load("sbi.functionscatalog.filevalue");}}</label>
	       								<input ng-model="u.value" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	   								</md-input-container>
	  								<md-icon class="md-secondary" md-font-icon="fa fa-trash" ng-click="output=removeInputFile(i)" aria-hidden="true" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))"></md-icon>
								</md-list-item>
						-->
							  <md-list-item ng-repeat="inputFile in shownFunction.inputFiles" layout="row">
							  	<md-input-container class="md-block" flex=40>
	           						<label>{{translate.load("sbi.functionscatalog.filealias");}}</label>
	       							<input ng-model="inputFile.alias" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	   							</md-input-container>
							  	{{translate.load("sbi.functionscatalog.selectafile");}}
					  		  	<file-upload-base64 id="id_file_upload-{{$index}}" flex=20 ng-model="inputFile" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))"></file-upload-base64>												
							  	<md-icon class="md-secondary" md-font-icon="fa fa-trash" ng-click="output=removeInputFile(i)" aria-hidden="true" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))"></md-icon>
							 	<a flex=30 ng-if="inputFile.filename!=undefined && inputFile.filename!=null && inputFile.filename!=''">Loaded {{inputFile.filename}}</a>
							  </md-list-item>
							  
							</md-list>  
						</md-card-content>
					</md-card>
					
					
					
					
					
				</md-tab>
				
				<md-tab label='{{translate.load("sbi.functionscatalog.script");}}' ng-if="(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
					<md-card>
						<md-card-content>
	  					 	<md-radio-group ng-model="shownFunction.remote" >
	      						<md-radio-button ng-value=false class="md-primary" ng-click="radioButtonRemoteLocalPush('local')" style="outline: none; border: 0; ">{{translate.load("sbi.functionscatalog.local");}}</md-radio-button>
	      						<md-radio-button ng-value=true ng-click="radioButtonRemoteLocalPush('remote')" style="outline: none; border: 0; "> {{translate.load("sbi.functionscatalog.remote");}} </md-radio-button>
	    					</md-radio-group>	
	    					
	    					<md-input-container class="md-block" ng-if='languageHidden && shownFunction.remote==false'>
	            				<label>{{translate.load("sbi.functionscatalog.language");}}</label>
	            				<md-select ng-model="shownFunction.language">
	              					<md-option ng-repeat="language in languages" value="{{language}}">
	                					{{language}}
	              					</md-option>
	           					</md-select>
	          				</md-input-container>
	      						
	  						<md-input-container class="md-block md-input-has-value" ng-if="shownFunction.remote==false">
	          					<label class="customCodeMirrorLabel">{{translate.load("sbi.functionscatalog.script");}}</label>
	          					<textarea flex ui-refresh="true" ng-model="shownFunction.script" ui-codemirror ui-codemirror-opts="editorOptions"></textarea>
	        				</md-input-container>
										
							<md-input-container class="md-block" flex ng-if="shownFunction.remote==true">
		 						<label>{{translate.load("sbi.functionscatalog.url");}}</label>  
		 						<input ng-model="shownFunction.url" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
							</md-input-container>			
										
										
	        			</md-card-content>
	        		</md-card>			    					
				</md-tab>
				<md-tab label='{{translate.load("sbi.functionscatalog.output");}}'>
					<md-card class="noMdError smallInputs">
						<md-toolbar class="md-toolbar-tools secondaryToolbar">
							{{translate.load("sbi.functionscatalog.output");}} 
							<div flex></div>
							<md-button class="md-secondary" ng-click="output=addOutputItem()" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))">{{translate.load("sbi.functionscatalog.addoutput");}}</md-button> 		
						</md-toolbar>	
						<md-card-content>
							<md-list>
								<md-list-item ng-if="shownFunction.outputItems.length==0" class="messageItem" layout-align="center center">
									&emsp;&emsp;{{translate.load("sbi.functionscatalog.nooutputexpected");}}
								</md-list-item>
								<md-list-item ng-repeat="o in shownFunction.outputItems">
									<md-input-container class="md-block" flex>
	        							<label>{{translate.load("sbi.functionscatalog.label");}}</label>
	        							<input ng-model="o.label" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	      							</md-input-container>
	   								<md-input-container aria-hidden="true" class="md-block" flex>
		      							<label>{{translate.load("sbi.functionscatalog.type");}}</label>
		        						<md-select ng-model="o.type" ng-disabled="!(isAdmin || (isDev && shownFunction.owner==ownerUserName))">
	              							<md-option ng-repeat="type in outputTypes" value="{{type}}">
	                							{{type}}
	              							</md-option>
	           							</md-select>
	      							</md-input-container>
	  								<md-icon class="md-secondary" md-font-icon="fa fa-trash" ng-click="removeOutputItem(o)" aria-hidden="true" ng-show="(isAdmin || (isDev && shownFunction.owner==ownerUserName))"></md-icon>
								</md-list-item>
							</md-list>
						</md-card-content>
					</md-card>
				</md-tab>
		
							
       		</md-tabs>
       
       </detail>
	
		
	</angular-list-detail>



</div>

</body>
</html>
