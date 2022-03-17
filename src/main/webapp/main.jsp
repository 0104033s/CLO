<%@page import="board.Board"%>
<%@page import="board.BoardDAO"%>
<%@page import="brand.Brand"%>
<%@page import="brand.BrandDAO"%>
<%@page import="notice.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="notice" class="notice.Notice" scope="page"/>
<jsp:useBean id="brand" class="brand.Brand" scope="page"/>
<jsp:setProperty name="notice" property="*"/>
<jsp:setProperty name="brand" property="*"/>
<!DOCTYPE html>
<html>
<head>
<title>메인</title>

<style>
	.container{
		padding-top:100px;
		padding-bottom: 100px;
	}
	.board{

		padding:10px;
		
	}
	.table{
		text-align:center;
	}

	.brand{
		border:1px solid gray;
		margin:10px;
	}
	.tag{
		width:100%;
		height:100%;
	}
	.img{
		width: 100%;
		height: 100%;
	}
	.name{
		position: absolute;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		width:100%; 
		height:100%;
		display:none;
		padding:50px;
		text-align: center;
	}
	.tag:hover>.name{
		display:inline;
		background-color: rgba(0,0,0,0.8);
		border-radius: 10px;
		vertical-align: middle;
		
}	

</style>
</head>
<body>
	<%
		if(session.getAttribute("userID")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='login.jsp'");
		script.println("</script>");
		}
	%>
	<%@include file="header.jsp" %>
	<%@include file="footer.jsp" %>
	

	<div class="container row m-auto">
			<div class="board col-6">
				<table class="table">
					<thead>
						<tr>
							<th colspan="3"><a href="noticeList.jsp?pageNum=1">공지</a></th>
						</tr>
					</thead>
					
					<tbody>
					<%
					ArrayList<Notice> list = new NoticeDAO().noticeList(1);
					for(int i=0;i<list.size(); i++){ %>
						<tr>
							<td><%=list.get(i).getnNum() %>.
							<td style="text-align:left;"><a href="notice.jsp?nNum=<%=list.get(i).getnNum()%>"><%=list.get(i).getnTitle() %></a>
							<td><%=list.get(i).getnCount() %>
						</tr>
						<%} %>
						<colgroup>
							<col style="width:10%"/>
							<col style="width:80%"/>
							<col style="width:10%"/>
						</colgroup>
					</tbody>
				</table>
			</div>
			
			<div class="board col-6">
				<table class="table">
					<thead>
						<tr>
							<th colspan="3"><a href="brandList.jsp?pangNum=1">게시판</a></th>
						</tr>
					</thead>
					<%ArrayList<Board> blist = new BoardDAO().boardList("",1);%>
					<tbody>
					<%for(int i=0; i<blist.size();i++){ %>
						<tr>
							<td><%=blist.get(i).getbNum() %>
							<td style="text-align:left;"><a href="board.jsp?boardNum=<%=blist.get(i).getbNum() %>"><%=blist.get(i).getbTitle() %></a>
							<td><%=blist.get(i).getbCnt() %>
						</tr>
						<%} %>
						<colgroup>
							<col style="width:10%"/>
							<col style="width:80%"/>
							<col style="width:10%"/>
						</colgroup>
					</tbody>
				</table>
			</div>
	</div>
	<!-- 브랜드 목록 -->
	
	<%
	String bWord=request.getParameter("bWord");
	
	ArrayList<Brand> brandList = new BrandDAO().brandList(bWord);
	%>
	<div class="container row m-auto" style="text-align: center;">
		<h2 class="m-auto">게시판 이동</h2>
		<div class="word m-auto pt-2">
			<a href="main.jsp?bWord=">ALL.</a>
			
		<%for(int i=65;i<=90;i++){ %>
			<a href="main.jsp?bWord=<%=(char)i %>"><%=(char)i %></a>
		<%} %>
			
	</div>
		<div class="col-1"></div>
		<div class="col-10 m-auto row pt-2">
			<% for(int i=0; i<brandList.size(); i++){%>
			<div class="brand col-2 " style="height:150px; position:relative; ">
				<a href="boardList.jsp?pageNum=1&brand=<%=brandList.get(i).getbName() %>" class="tag" >
				<img class="img" src="resource/img/brand/<%=brandList.get(i).getbImg() %>"/>
				<span class="name"><%=brandList.get(i).getbName() %></span>
				</a>
			</div>
			<%}%>
		</div>
		<div class="col-1"></div>
		</div>
	
</body>
</html>