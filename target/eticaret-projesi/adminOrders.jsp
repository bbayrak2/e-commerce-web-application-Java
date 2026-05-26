<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Yönetim Paneli - Siparişler</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Panel / Sipariş Yönetimi</h2>
        <a href="admin.jsp" class="btn btn-secondary">Ürün Yönetimine Geç</a>
    </div>

    <table class="table table-bordered bg-white shadow-sm align-middle">
        <thead class="table-dark">
            <tr>
                <th>Sipariş No</th>
                <th>Müşteri ID</th>
                <th>Adres</th>
                <th>Tutar</th>
                <th>Mevcut Durum</th>
                <th>Durumu Değiştir</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td><strong>#${order.id}</strong></td>
                    <td>${order.userId}</td>
                    <td><small>${order.address}</small></td>
                    <td>${order.totalPrice} TL</td>
                    <td>
                        <span class="badge ${order.status == 'Hazırlanıyor' ? 'bg-warning text-dark' : order.status == 'Kargoya Verildi' ? 'bg-info text-dark' : 'bg-success'}">
                            ${order.status}
                        </span>
                    </td>
                    <td>
                        <form action="admin-orders" method="post" class="d-flex gap-2">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <select name="status" class="form-select form-select-sm" style="width: 160px;">
                                <option value="Hazırlanıyor" ${order.status == 'Hazırlanıyor' ? 'selected' : ''}>Hazırlanıyor</option>
                                <option value="Kargoya Verildi" ${order.status == 'Kargoya Verildi' ? 'selected' : ''}>Kargoya Verildi</option>
                                <option value="Teslim Edildi" ${order.status == 'Teslim Edildi' ? 'selected' : ''}>Teslim Edildi</option>
                            </select>
                            <button type="submit" class="btn btn-sm btn-primary">Güncelle</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>