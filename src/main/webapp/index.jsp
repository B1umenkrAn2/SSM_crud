<%--
  Created by IntelliJ IDEA.
  User: HaloZ
  Date: 4/24/2021
  Time: 7:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>SSM CRUD</title>
    <link href="${APP_PATH}/static/bootstrap/bootstrap.min.css" rel="stylesheet"/>
    <script src="${APP_PATH}/static/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>


<div class="modal fade" id="empAddModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >New Employee</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <%-- empName --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%-- email --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@gmail.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%-- gender --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">

                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="m"
                                       checked="checked"> Male
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="f"> Female
                            </label>
                        </div>
                    </div>
                    <%-- department --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">

                            <select class="form-control" name="dId" id="dept_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>



<div class="modal fade" id="empUpdateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Employee Info Edit</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">


                <form class="form-horizontal">
                    <%-- empName --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <%-- email --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@gmail.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%-- gender --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">

                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M"
                                       checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <%-- department --%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">

                            <select class="form-control" name="dId" id="dept_select"></select>
                        </div>
                    </div>
                </form>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid">


    <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>

    <div class="row">
        <div class="col-lg-4">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Name or id" id="search_emp">
                    <span class="input-group-btn">
                        <button class="btn btn-primary glyphicon glyphicon-search" type="button" id="search_btn">Search</button>
                    </span>
                </div>
            </div>
        <div class="col-md-4 col-md-offset-4">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#empAddModal" id="emp_add_modal_btn">
                New Employee
            </button>
                <button class="btn btn-danger" id="emp_delete_batch_btn">Delete</button>
            </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>#</th>
                    <th>Employee Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Department Name</th>
                    <th>Option</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

</div>
<script type="text/javascript">

    let totalRecordCount;
    let currentPage;
    $(function () {
        to_page(1);
    });

    function to_page(page) {
        $("#check_all").prop("checked", false);
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + page,
            type: "GET",
            success: function (res) {
                build_emps_table(res);
                build_page_info(res);
                build_page_nav(res);
            }
        });
    }

    function build_emps_table(res) {
        $("#emps_table tbody").empty();
        let emps = res.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            let checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            let empIdTd = $("<td></td>").append(item.empId);
            let empNameTd = $("<td></td>").append(item.empName);
            let genderTd = $("<td></td>").append(item.gender === 'm' ? "Male" : "Female");
            let emailTd = $("<td></td>").append(item.email);
            let deptNameTd = $("<td></td>").append(item.department.deptName);
            let editBtn = $("<button data-bs-toggle=\"modal\" data-bs-target=\"#empUpdateModal\"></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("Edit"));
            editBtn.attr("edit-id", item.empId);
            let delBtn = $("<button ></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("Delete"));
            delBtn.attr("del-id", item.empId);
            let btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    function build_page_nav(res) {

        $("#page_nav_area").empty();
        let ul = $("<ul></ul>").addClass("pagination");

        let firstPageLi = $("<li class='page-item'></li>").append($("<a class='page-link'></a>").append("First Page").attr("href", "#"));
        let prePageLi = $("<li class='page-item'></li>").append($("<a class='page-link'></a>").append("&laquo;"));

        if (res.extend.pageInfo.hasPreviousPage === false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {

            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(res.extend.pageInfo.pageNum - 1);
            });
        }

        let nextPageLi = $("<li class='page-item'></li>").append($("<a class='page-link'></a>").append("&raquo;"));
        let lastPageLi = $("<li class='page-item'></li>").append($("<a class='page-link'></a>").append("Last page").attr("href", "#"));

        if (res.extend.pageInfo.hasNextPage === false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {

            nextPageLi.click(function () {
                to_page(res.extend.pageInfo.pageNum + 1);
            });

            lastPageLi.click(function () {
                to_page(res.extend.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(res.extend.pageInfo.navigatepageNums, function (index, item) {
            let numLi = $("<li class='page-item'></li>").append($("<a class='page-link'></a>").append(item));

            numLi.click(function () {
                to_page(item);
            })

            if (res.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            ul.append(numLi);
        })

        ul.append(nextPageLi).append(lastPageLi);

        let navEle = $("<nav></nav>").append(ul).appendTo("#page_nav_area");
    }

    function build_page_info(res) {

        $("#page_info_area").empty();
        $("#page_info_area").append("Current " + res.extend.pageInfo.pageNum + "/" +
            res.extend.pageInfo.pages + " Page，Total " +
            res.extend.pageInfo.total + " records。");

        totalRecordCount = res.extend.pageInfo.total;

        currentPage = res.extend.pageInfo.pageNum;
    }

    function reset_form(ele) {

        $(ele)[0].reset();

        $(ele).find("*").removeClass("has-error has-success");

        $(ele).find(".help-block").text("");
    }

    $("#emp_add_modal_btn").click(function () {

        reset_form("#empAddModal form");

        getDepts("#empAddModal select");

    });

    function getDepts(ele) {

        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (res) {

                $.each(res.extend.depts, function () {

                    let optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);

                });
            }
        });
    }

    function show_validate_msg(ele, status, msg) {

        $(ele).parent().removeClass("has-success has-error");

        $(ele).next("span").text("");
        if ("success" === status) {

            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {

            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    function validate_add_form() {

        let empName = $("#empName_add_input").val();

        let regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

        if (!regName.test(empName)) {

            show_validate_msg("#empName_add_input", "error", "Username length must 6-16");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        let email = $("#email_add_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "Email format error!");
            return false;
        } else {

            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    let emailStatus;
    $("#email_add_input").change(function () {
        if (!validate_add_form()) {
            show_validate_msg("#email_add_input", "error", "Email format error");
            emailStatus = false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
            emailStatus = true;
        }
    })

    $("#empName_add_input").change(function () {

        let empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (res) {
                if (res.code == 100) {

                    show_validate_msg("#empName_add_input", "success", "Username can be use");

                    $("#emp_save_btn").attr("ajax-value", "success");
                } else {

                    show_validate_msg("#empName_add_input", "error", res.extend.va_msg);

                    $("#emp_save_btn").attr("ajax-value", "error");
                }
            }
        })
    })

    $("#emp_save_btn").click(function () {

        if ($(this).attr("ajax-value") == "error") {
            return false;
        }
        if (!validate_add_form() || !emailStatus) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (res) {



                    if (res.extend.errorField.email != undefined) {

                        show_validate_msg("#email_add_input", "error", res.extend.errorField.email);
                    }

                    if (res.extend.errorField.empName != undefined) {

                        show_validate_msg("#empName_add_input", "error", res.extend.errorField.empName);
                    }

            }
        });
    });

    $(document).on("click", ".edit_btn", function () {

        getEmp($(this).attr("edit-id"));

        getDepts("#empUpdateModal select");

        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

    })

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (res) {

                let empData = res.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name = gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    $("#email_update_input").change(function () {
        validate_update_email();
    })

    function validate_update_email() {
        let email = $("#email_update_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "Email format error!");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        return true;
    }

    $("#emp_update_btn").click(function () {

        let email = $("#email_update_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "Email format error!");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        $.ajax({

            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (res) {


                $('#empUpdateModal').modal('hide');

                to_page(currentPage);
            }
        })
    })

    $(document).on("click", ".delete_btn", function () {

        let empName = $(this).parents("tr").find("td:eq(2)").text();

        let empId = $(this).attr("del-id");

        if (confirm("Delete Employee [" + empName + "] ？")) {

            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (res) {
                    alert(res.msg);
                    to_page(currentPage);
                }
            })
        }
    });

    $("#check_all").click(function () {

        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check_item", function () {
        let flag = $(".check_item:checked").length === $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })

    $("#emp_delete_batch_btn").click(function () {
        let empNames = "";
        let del_idstr = "";

        $.each($(".check_item:checked"), function () {

            empNames += $(this).parents("tr").find("td:eq(2)").text() + "\n";

            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("Delete  Employee" + empNames + " ？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (res) {
                    alert(res.msg);
                    to_page(currentPage);
                }
            })
        }
    });

    $("#search_btn").click(function () {

        $("#emps_table tbody").empty();

        let searchContent = $("#search_emp").val();
        console.log(searchContent);
        $("#page_nav_area").empty();

        if (searchContent === "") {
            to_page(1);
        } else {

            $.ajax({
                url: "${APP_PATH}/empSearch",
                type: "GET",
                data: "content=" + searchContent,
                success: function (res) {

                    search_emps_table(res);

                    build_search_page_info(res);
                }
            });
        }
    })

    function search_emps_table(res) {

        $("#emps_table tbody").empty();

        let empSearched = res.extend.pageInfo.list;

        if (empSearched.length === 0) {
            $("<h5></h5>").append("").append("NOT FOUND")
                .appendTo("#emps_table tbody");
        } else {

            $.each(empSearched, function (i, val) {

                let checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                let empIdTd = $("<td></td>").append(empSearched[i].empId);
                let empNameTd = $("<td></td>").append(empSearched[i].empName);
                let genderTd = $("<td></td>").append(empSearched[i].gender === 'm' ? "Male" : "Female");
                let emailTd = $("<td></td>").append(empSearched[i].email);
                let deptNameTd = $("<td></td>").append(empSearched[i].department.deptName);

                let editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("Edit"));

                editBtn.attr("edit-id", empSearched[i].empId);

                let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("Delete"));

                delBtn.attr("del-id", empSearched[i].empId);

                let btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })
        }
    }

    function build_search_page_info(res) {

        $("#page_info_area").empty();
        $("#page_info_area").append("find " + res.extend.pageInfo.total + " records。");
    }
</script>
</body>

</html>
