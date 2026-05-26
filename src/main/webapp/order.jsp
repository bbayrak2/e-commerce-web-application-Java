<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Siparişlerim</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📦 Siparişlerim</h2>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Alışverişe Dön</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="text-center p-5 text-muted">
                        <h4>Henüz hiç sipariş vermemişsiniz.</h4>
                        <p>Sepetinizi doldurmanın tam zamanı!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Sipariş No</th>
                                    <th>Tarih</th>
                                    <th>Teslimat Adresi</th>
                                    <th>Toplam Tutar</th>
                                    <th>Durum</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td><strong>#${order.id}</strong></td>
                                        <td>${order.orderDate}</td>
                                        <td><small>${order.address}</small></td>
                                        <td><strong>${order.totalPrice} TL</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'Hazırlanıyor'}">
                                                    <span class="badge bg-warning text-dark">⏳ Hazırlanıyor</span>
                                                </c:when>
                                                <c:when test="${order.status == 'Kargoya Verildi'}">
                                                    <span class="badge bg-info text-dark">🚚 Kargoda</span>
                                                </c:when>
                                                <c:when test="${order.status == 'Teslim Edildi'}">
                                                    <span class="badge bg-success">✅ Teslim Edildi</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

</body>
</html>