<!DOCTYPE HTML>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Pragma" content="no-cache"> 
    <meta http-equiv="Cache-Control" content="no-cache"> 
    <meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
    
    <title>Nhom 6 | Home</title>
    
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
     <link href="static/css/style.css" rel="stylesheet">
    
    <!--[if lt IE 9]>
		<script src="static/js/html5shiv.min.js"></script>
		<script src="static/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>

	<div role="navigation">
		<div class="navbar navbar-inverse">
			<a href="/" class="navbar-brand">Bootsample</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="all-tasks">All Posts</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<c:choose>
		<c:when test="${mode == 'MODE_TASKS'}">
			<div class="container text-center" id="tasksDiv">
				<h3>My Post</h3>
				<hr>
				<div class="table-responsive">
					<table class="table table-striped table-bordered text-left">
						<thead>
							<tr>
								<th>Id</th>
								<th>Title</th>
								<th>Content</th>
								<th>Url</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="task" items="${posts}">
								<tr>
									<td>${task.id}</td>
									<td>${task.title}</td>
									<td>${task.content}</td>
									<td>${task.url}</td>
									<td><a href="update-task?id=${task.id}"><span class="glyphicon glyphicon-pencil"></span></a></td>
									<td><a href="delete-task?id=${task.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</c:when>
		<c:when test="${mode == 'MODE_NEW'}">
			<div class="container text-center">
				<div class="container" id="homeDiv">
				<div class="jumbotron text-center">
					<h2 style="color:red">Welcome to Post Manager Nhom 6</h2>
				</div>
			</div>
				<hr>
				<form:form action="/" enctype="multipart/form-data"
			modelAttribute="post" role="form">
			<div class="form-group">
				<label class="control-label">Tiêu đề</label>			
				<center><form:input path="title" class="form-control" style="width:60%" />	</center>		
			</div>
			<br>
			<div class="form-group">
				<label class="control-label">Mô tả</label>		
				<center><form:textarea id="content" class="form-control" name="content" path="content" /></center>	
			</div>
			<br>
			
				<label class="col-md-1" >File</label> 
					<input id="file" class="col-md-3" type="file" name="file">
			
			<br>
			<br>
			<div class="form-group">
				<input class="btn btn-success" class="form-control" type="submit" value="Lưu"/>
			</div>
		</form:form>
		<div class="jumbotron text-center">
			${message}
		</div>
			</div>
		</c:when>		
	</c:choose>
	
<script src="<c:url value="ckeditor/ckeditor.js" />"></script>
<script type="text/javascript" language="javascript">
   CKEDITOR.replace('content', {width: '700px',height: '300px'}); 
</script>
	<script src="static/js/jquery-1.11.1.min.js"></script>    
    <script src="static/js/bootstrap.min.js"></script>
</body>
</html>