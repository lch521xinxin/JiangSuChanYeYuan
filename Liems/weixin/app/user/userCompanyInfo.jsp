<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="aweto"  uri="http://wwww.aweto-framework.org/taglibs/AwetoTag" %> 
<%@ taglib prefix="weixin"  uri="http://wwww.aweto-framework.org/taglibs/weixinTag" %> 
<!DOCTYPE html>
<html lang="zxx">
<head>
	<meta charset="UTF-8">
	<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" name="viewport"/>
	<title><aweto:pageTile/></title>
	<aweto:basePath />
	<base href="${basePath}" />
	<weixin:sessionInfo debug="true"/>
	<aweto:decoration version="2.0" mobile="true"/>
	<aweto:entityInfo name="org.aweto.web.entity.WebCompany"/>
	<script type="text/javascript" src="aweto/ui/core/template/detailTemplate-2.0.js?v=20200217"></script>
	<script type="text/javascript">
		var namespace='/web/webCompany';
		var uscCode;
		$(function(){
			action="view";
			pkValue=comNo;
			init({
				url:basePath+namespace+"/find.ajax",
	            saveUrl:basePath+namespace+"/save.ajax?submit=true",
				form:$("#detailForm"),
				floating:false,
				onLoad:function(pk,recorder){
					if(pk=="-1"){
						layer.msg("未找到企业信息！", {icon: 5});//不开心
					}else{
						$("#comName").html(recorder.comName);
						$("#uscCode").html(recorder.uscCode);
						$("#boss").html(recorder.boss);
						$("#comCentifyState").html(recorder.comCentifyState.selectedText);
						uscCode=recorder.uscCode;
					}
				},beforeSubmit:function(data){
					return data;
				},afterSubmit:function(rtn){
					return true;
				}
			});
		});
		
		function unjoinCom(){
			layer.confirm("确认退出企业 ？", {
				  btn: ['确认', '取消'] //按钮
				}, function(){
					doUnJoin();
				}, function(){
					
				});
		}
		
		function doUnJoin(){
			obj=$("#submitBtn");
			layer.load();
			if(obj){
				$(obj).html("数据提交中...");
				$(obj).attr("disabled","disabled");
			}
			aweto.ajax(basePath+"web/user/unjoinCompany.ajax",{userId:userId,from:"user"},true,function(r){
				layer.closeAll("loading");
				if(r.state==SUCCESS){
					layer.msg(r.msgInfo, {icon: 1});//成功
					weixin.toIndex();
				}else{
					layer.closeAll("loading");
					if(obj){
						$(obj).html("提交");
						$(obj).removeAttr("disabled");
					}
					layer.msg(r.msgInfo, {icon: 5});//不开心
				}
			})
		}
		
	</script>
</head>
<body>
	<!-- navbar -->
	<div class="navbar">
		<div class="container">
			<div class="row">
				<div class="col s9">
					<div class="content-left">
						<a href="javascript:weixin.toUserInfo()"><h1><i class="fa fa-chevron-left"></i><span></span>企业信息</h1></a>
					</div>
				</div>
				<div class="col s3">
					<div class="content-right">
						<a href="javascript:weixin.toIndex()" class='backBar'><i class="fa fa-home"></i></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end navbar -->
	
	<!-- sidebar -->
	<!-- end sidebar -->

	<!-- contact -->
	<div class="contact segments-page">
		<div class="content-container">
			<div class="contact-contents">
				<div class="pages-title">
					<h3>我所在企业信息</h3>
					<div class="line"></div>
				</div>
				<div class="wrapper wrapper-content">
					<form class="form-horizontal" id="detailForm" novalidate="novalidate">
						<div class="form_title hidden"> <span> 企业基本信息 </span> </div>
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label class="col-sm-4 control-label" >企业名称：<font id="comName"></font></label>
								</div>
							</div>
							<div class="col-sm-6 ">
								<div class="form-group">
									<label class="col-sm-4 control-label" >信用代码：<font id="uscCode"></font></label>
								</div>
							</div>
							<div class="col-sm-6 ">
								<div class="form-group">
									<label class="col-sm-4 control-label" >企业负责人：<font id="boss"></font></label>
								</div>
							</div>
							<div class="col-sm-6 hidden">
								<div class="form-group">
									<label class="col-sm-4 control-label" >认证状态：<font id="comCentifyState"></font></label>
								</div>
							</div>
						</div>
						<div class=" ">
					      <div class="col-sm-12 btn-container">
			                    <a id="submitBtn" class="btn btn-primary  btn-block" href="javascript:unjoinCom(this)"><i class="fa fa-remove"></i>退出该企业</a>
						  </div>
					   </div>
						<br/>
					</form>
				</div>     
			</div>
		</div>
	</div>
	<!-- end contact -->
</body>
</html>
