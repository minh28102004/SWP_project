<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update User</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            body {
                background-color: #f5f5f5;
                font-family: 'Roboto', sans-serif;
                font-size: 14px;
            }
            .container {
                margin-top: 20px;
            }
            .btn {
                margin-right: 5px;
            }
            table {
                width: 100%;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-top: 20px;
                overflow: hidden;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
            }
            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            form {
                display: inline-block;
                margin-bottom: 0;
            }
            .form-control {
                width: 100%;
            }
            .btn-search {
                margin-bottom: 10px;
            }
            .pt-5 {
                position: absolute;
                bottom: 20px;
                left: 20px;
                text-decoration: none;
                color: black;
                transition: color 0.2s, transform 0.2s ease;
            }

            .pt-5:hover {
                color: #3498db;
                transform: translateX(-3px); /* Hiệu ứng dịch chuyển */
                text-decoration: none;
            }

            .pt-5 i {
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form action="MainController" method="POST" class="form-inline">
                <div class="form-group mb-2">
                    <input type="text" class="form-control" name="txtSearchValue" placeholder="Enter Name" value="${param.txtSearchValue}">
                </div>
                <input type="submit" class="btn btn-primary mb-2 ml-2" name="btAction" value="Search Name"/>
            </form>

            <c:if test="${ not empty param.txtSearchValue}">
                <c:set var="userList" value="${requestScope.SEARCHED_USER_LIST}"/>
            </c:if>
            <c:if test="${ empty param.txtSearchValue}">
                <c:set var="userList" value="${sessionScope.USER_LIST}"/>
            </c:if>

            <c:if test="${not empty userList}">
                <table class="table table-striped table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>User Name</th>
                            <th>Full Name</th>
                            <th>Password</th>
                            <th>Address</th>
                            <th>Sex</th>
                            <th>Phone number</th>
                            <th>Email</th>
                            <th>Role ID</th>
                            <th>Delete</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}" varStatus="i">
                        <form action="MainController" method="POST">
                            <tr>
                                <td>${user.userName}<input type="hidden" name="txtUserName" value="${user.userName}"/></td>
                                <td>${user.fullName}</td>
                                <td>${user.password}</td>
                                <td>${user.address}</td>
                                <td>${user.sex}</td>
                                <td>${user.phoneNumber}</td>
                                <td>${user.email}</td>
                                <td>
                                    <select class="form-control" name="txtRoleId">
                                        <option value="${user.roleID}" selected>${user.roleID}</option>
                                        <option value="AD">AD</option>
                                        <option value="US">US</option>
                                    </select>
                                </td>
                                <td><a href="MainController?btAction=Delete User&txtDeleteValue=${user.userName}&txtLastSearchValue=${param.txtSearchValue}" class="btn btn-danger btn-sm">Delete</a></td>
                                <td>
                                    <input type="hidden" name="txtLastSearchValue" value="${param.txtSearchValue}"/>
                                    <input type="submit" name="btAction" value="Update User" class="btn btn-info btn-sm"/>
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <a href="Menu.jsp" class="pt-5 back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>
        </div>
    </body>
</html>
