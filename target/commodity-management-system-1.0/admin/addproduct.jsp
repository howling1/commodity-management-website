<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
	</head>
    <script type="text/javascript">
        function fileChange(){//注意：此处不能使用jQuery中的change事件，因此仅触发一次，因此使用标签的：onchange属性
           // Jquery function for uplaoding file to server via ajax
            $.ajaxFileUpload({
                url: '${pageContext.request.contextPath}/prod/ajaxImg.action',//用于文件上传的服务器端请求地址
                secureuri: false,//一般设置为false
                fileElementId: 'pimage',//文件上传控件的id属性  <input type="file" id="pimage" name="pimage" />
                dataType: 'json',//返回值类型 一般设置为json
                success: function(obj) //服务器成功响应处理函数
                {
                    $("#imgDiv").empty();  //清空原有数据
                    //创建img 标签对象
                    var imgObj = $("<img>");
                    //给img标签对象追加属性
                    imgObj.attr("src","${pageContext.request.contextPath}/image_big/"+obj.imgurl);
                    imgObj.attr("width","100px");
                    imgObj.attr("height","100px");
                    //将图片img标签追加到imgDiv末尾
                    $("#imgDiv").append(imgObj);
                    //将图片的名称（从服务端返回的JSON中取得）赋值给文件本框
                    //$("#imgName").html(data.imgName);
                },
                error: function (e)//服务器响应失败处理函数
                {
                    alert(e.message);
                }
            });
        }
    </script>
	<body>
	<!--取出上一个页面上带来的page的值-->

		<div id="addAll">
			<div id="nav">
				<p>Commodity Management>Add Commodity</p>
			</div>

			<div id="table">
				<form action="${pageContext.request.contextPath}/prod/save.action" enctype="multipart/form-data"
					  method="post" id="myform">
					<table>
						<tr>
							<td class="one">Commodity Name</td>
							<td><input type="text" name="pName" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pnameerr"></span></td>
						</tr>
						<tr>
							<td class="one">Commodity Introduction</td>
							<td><input type="text" name="pContent" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="pcontenterr"></span></td>
						</tr>
						<tr>
							<td class="one">Price</td>
							<td><input type="number" name="pPrice" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="priceerr"></span></td>
						</tr>
						
						<tr>
							<td class="three">Picture</td>
                            <td> <br><div id="imgDiv" style="display:block; width: 40px; height: 50px;"></div><br><br><br><br>
								<%--<input type="file" id="pimage" name="pimage" onchange="fileChange()">--%>
                            <input type="file" id="pimage" name="pimage" onchange="fileChange()" >
                                <span id="imgName" ></span><br>

                            </td>
						</tr>
						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>
						
						<tr>
							<td class="one">Total Amount</td>
							<td><input type="number" name="pNumber" class="two"></td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span id="numerr"></span></td>
						</tr>
						
						
						<tr>
							<td class="one">Category</td>
							<td>
								<select name="typeId">
									<c:forEach items="${productTypes}" var="type">
										<option value="${type.typeId}">${type.typeName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<!--错误提示-->
						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>

						<tr>
							<td>
								<input type="submit" value="Submit" class="btn btn-success">
							</td>
							<td>
								<input type="reset" value="Cancel" class="btn btn-default" onclick="myclose(${param.page})">
								<script type="text/javascript">
									function myclose(ispage) {
										$.ajax({
											url:"${pageContext.request.contextPath}/prod/clearImageFileName.action",
											type:"get",
											success:function () {
												window.location="${pageContext.request.contextPath}/prod/displayProds.action";
											}
										})
									}
								</script>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

	</body>

</html>