<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>E-Ticaret | Sepetim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-4 mb-3">
        <a href="home" class="btn btn-outline-secondary">&larr; Alışverişe Dön</a>
    </div>

    <div class="container">
        <h2 class="mb-4">Alışveriş Sepetim</h2>

        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <div class="alert alert-info text-center" role="alert">
                    Sepetinizde henüz ürün bulunmamaktadır.
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Ürün</th>
                                    <th>Birim Fiyat</th>
                                    <th>Adet</th>
                                    <th>Ara Toplam</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="grandTotal" value="0" />
                                
										<c:forEach var="item" items="${sessionScope.cart.items}">                                    <tr>
                                        <td>${item.product.name}</td>
                                        <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="TL"/></td>
                                        
                                        <td>
                                            <form action="cart" method="post" class="d-flex align-items-center">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}" class="form-control form-control-sm w-50 me-2">
                                                <button type="submit" class="btn btn-sm btn-info text-white">Yenile</button>
                                            </form>
                                            <small class="text-muted">Stok: ${item.product.stock}</small>
                                        </td>
                                        
                                        <td class="fw-bold">
                                            <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="TL"/>
                                        </td>
                                        
                                        <td>
                                            <form action="cart" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <button type="submit" class="btn btn-sm btn-danger">Çıkar</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <c:set var="grandTotal" value="${grandTotal + item.subTotal}" />
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <div class="d-flex justify-content-end align-items-center mt-4">
                            <h4 class="me-4">Genel Toplam: <span class="text-success"><fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="TL"/></span></h4>
                            
                            <a href="checkout.jsp" class="btn btn-success btn-lg">Siparişi Tamamla &rarr;</a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>