<%@page import="model.OrderDetailBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.OrderDetailRawBean"%>
<%@ page import="model.CustomizeBean"%>
<%@ page import="java.text.NumberFormat"%>
<%
	List<OrderDetailRawBean> rawOrderList = (List<OrderDetailRawBean>) session.getAttribute("rawOrderList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tappy - ご注文内容確認</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
  <jsp:include page="/WEB-INF/jsp/header.jsp"></jsp:include>
  <div class="wrapper">
<%-- 注文内容が空なら別の内容（購入ボタン）を表示する --%>
<% if(rawOrderList.isEmpty()) {%>
  <h3>注文内容がありません。</h3>
  <h3><a href="/tappy/ItemList">商品一覧</a>から商品をご注文ください。</h3>

<%}else{ %>
    <h3>注文が新たに決定されました。</h3>
    <h3>以下の注文でよろしければ【注文確定】のボタン、</h3>
    <h3>追加でご注文される場合は【追加注文】のボタンを押してください。</h3>


    <!--
<p>【イメージ：セッションスコープに入れられた注文内容を引っ張ってくる】</p>
<p>注文されたドリンクの分だけ配列が作られる？</p>
<p>【商品コード、サイズ、あまさ、こおり、たぴおか種、タピオカ量、トッピングを表示】画像も</p>
<p>【値段、個数を表示】</p>
<p>↑を配列数だけ繰り返す</p>
<p>【合計値段を表示】</p>
<br><p>以下、例</p><br>
-->

    <%
    	int sum = 0;

    	for (int i = 0; rawOrderList.size() > i; i++) {
    		OrderDetailRawBean odrb = rawOrderList.get(i);
    		if (odrb == null) {
    			continue;
    		}

    		sum += odrb.getItem().getItemPrice() * odrb.getPurchaseQuantity();

    %>

    <!-- <img src="TapiocaBread.jpg" alt="タピオカドリンク・サーモンピンク味"> -->
    <div class="menu-item">
      <div class="menu-photo">
        <img src="<%=odrb.getItem().getItemImageUrl()%>" style="width:550px"><br>
      </div>
      <div class="menu-text">
        <h2><%=odrb.getItem().getItem()%></h2>
        <p>
         【<%=odrb.getDrinkSize().getCustomize()%>・<%=odrb.getDrinkSugar().getCustomize()%>・<%=odrb.getIceAmount().getCustomize()%>・<%=odrb.getTapiokaKind().getCustomize()%>・<%=odrb.getTapiokaAmount().getCustomize()%>・トッピング：<%=odrb.getTopping().getCustomize()%>】
        </p>
        <p>
          金額：<%=odrb.getItem().getItemPrice()%>×<%=odrb.getPurchaseQuantity()%></p>

    <form method="POST" action="/tappy/OrderModify">
      <br> <input type="hidden" name="orderId" value="<%=i%>"> <input type="submit" name="modify" value="取り消す">
      <!--スコープから取り除くメソッド -->
      <br> <input type="submit" name="modify" value="変更する">
    </form>
      </div>
    </div>
    <%
    	}
    %>
    <h4>
      合計金額：￥<%=NumberFormat.getNumberInstance().format(sum)%></h4>

		<script type="text/javascript">
		window.onload = function () {
		var date = new Date();

		date.setDate(date.getDate());/*今日の日付*/
		var yyyy = date.getFullYear();
		var mm = ("0"+(date.getMonth()+1)).slice(-2);
		var dd = ("0"+date.getDate()).slice(-2);

		document.getElementById("today").value=yyyy+'-'+mm+'-'+dd;
		document.getElementById("today").min=yyyy+'-'+mm+'-'+dd;/*今日より前は選択できません*/
		}
		</script>

		<p>配達日を指定してください：</p>
		<p><input type="date" name="today" id="today" required></p>


    <form method="GET" action="/tappy/OrderComplete">
      <br> <input type="submit" name="name" value="注文確定">
    </form>


    <form method="GET" action="/tappy/ItemList">
      <br> <input type="submit" name="name" value="追加注文">
      <%-- 商品一覧ページmenu.jsp--%>
    </form>
    <%} %>
  </div>
  <jsp:include page="/WEB-INF/jsp/footer.jsp"></jsp:include>
</body>
</html>