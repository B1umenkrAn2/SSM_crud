<%--
  Created by IntelliJ IDEA.
  User: HaloZ
  Date: 4/24/2021
  Time: 1:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
        <link href="${APP_PATH}/static/bootstrap/bootstrap.min.css" rel="stylesheet" />
        <script src="${APP_PATH}/static/bootstrap/bootstrap.bundle.min.js"></script>
    <title>SSM CRUD</title>
</head>
<body>
    <div class="container-fluid">
     <header>
         <nav class="navbar navbar-expand-lg navbar-light bg-light">
             <div class="container-fluid">
                 <a class="navbar-brand" href="#">SSM CRUD</a>
                 <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                     <span class="navbar-toggler-icon"></span>
                 </button>
                 <div class="collapse navbar-collapse" id="navbarSupportedContent">
                     <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                         <li class="nav-item">
                             <a class="nav-link active" aria-current="page" href="#">Add</a>
                         </li>
                         <li class="nav-item">
                             <a class="nav-link" href="#">Delete </a>
                         </li>
                     </ul>
                     <form class="d-flex">
                         <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                         <button class="btn btn-outline-success" type="submit">Search</button>
                     </form>
                 </div>
             </div>
         </nav>
     </header>

        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>Employee Name</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>Department Name</th>
                        <th>Option</th>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender == "M" ? "Male" : "Famle"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-info btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    Edit
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    Delete
                                </button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                At ${pageInfo.getPageNum()}/${pageInfo.getPages()} page，total${pageInfo.getTotal()} records。
            </div>
            <div class="col-md-6">

                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pn=1">FirstPage</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li class="page-item">
                                <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    Previous
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <c:if test="${page_num == pageInfo.pageNum}">
                                <li class="active page-link"><a href="#">${page_num}</a></li>
                            </c:if>
                            <c:if test="${page_num != pageInfo.pageNum}">
                                <li><a class="page-link" href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li class="page-item">
                                <a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    Next
                                </a>
                            </li>
                        </c:if>
                        <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pn=${pageInfo.pages}">Last page</a></li>
                    </ul>
                </nav>

            </div>
        </div>






    </div>
</body>
</html>
