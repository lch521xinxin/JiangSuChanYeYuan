<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.aweto.system.util.base.Charset"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.aweto.weixin.util.WxUtil"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.aweto.app.util.LoginTools" %>
<%@ page import="org.aweto.web.util.base.WebTools"%>
<%@ page import="org.aweto.web.entity.WebUser"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userState=WxUtil.checkAuth2("ZHYQ",request, response,true);
	String openid=Charset.nullToEmpty(request.getSession().getAttribute("openid"));
	System.out.println("openId:"+openid);
	String userId=null;
	String userName="";
	if(!"".equals(openid)){
		WebUser u=WebTools.getUserByOpenid(openid);
		if(u!=null){
			userName=Charset.nullToEmpty(u.getUserNam());
		}
		System.out.println("用户名:"+userName);
		String code	= Charset.nullToEmpty(request.getParameter("code"));
		String state= Charset.nullToEmpty(request.getParameter("state"));
		userId=LoginTools.loginWebByWeixin(openid,request,state);
	}
	String msgInfo="登录失败！";
	String icon="weui-icon-info";
	 if(userId==null){
		msgInfo="扫码失败！</br>请关闭浏览器后重新打开再次扫码！";
	}else{
		if("new".equals(userState)){
			msgInfo="已成功注册用户，创建企业或关联企业后登陆！";
			icon="weui-icon-success";
		}else{
			msgInfo="登录成功！";
			icon="weui-icon-success";
		}
		
	}
%>
<!DOCTYPE html>
<html>
  <head>
    <title>操作提醒</title>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<link rel="stylesheet" href="<%=basePath %>weixin/ui/lib/weui.min.css">
	<link rel="stylesheet" href="<%=basePath %>weixin/ui/css/jquery-weui.css">
	<link rel="stylesheet" href="<%=basePath %>weixin/ui/demos/css/demos.css">
	<script type="text/javascript">
	 var basePath='<%=basePath %>';
	</script>
  </head>

  <body ontouchstart>

    <div class="weui-msg">
      <div class="weui-msg__icon-area"><i class=" <%=icon %> weui-icon_msg"></i></div>
      <div class="weui-msg__text-area">
        <h2 class="weui-msg__title"><%=msgInfo %></h2>
      </div>
      <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
        </p>
      </div>
      <div class="weui-msg__extra-area">
        <div class="weui-footer">
          <p class="weui-footer__links" style="display: none">
            <a href="javascript:void(0);" class="weui-footer__link">底部链接文本</a>
          </p>
          <p class="weui-footer__text">Copyright © 2008-2016 luculent</p>
        </div>
      </div>
    </div>
    <script src="<%=basePath %>weixin/ui/lib/jquery-2.1.4.js"></script>
	<script src="<%=basePath %>weixin/ui/lib/fastclick.js"></script>
<script>
</script>
	<script src="<%=basePath %>weixin/ui/js/jquery-weui.js"></script>

  </body>
</html>
