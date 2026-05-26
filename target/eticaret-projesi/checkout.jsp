<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Siparişi Tamamla</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="container mt-5">

    <h2 class="mb-4">Sipariş Özeti</h2>

    <!-- Toplam fiyat değişkeni -->
    <c:set var="totalPrice" value="0" />

    <table class="table table-bordered table-hover shadow-sm">

        <thead class="table-dark">
            <tr>
                <th>Ürün</th>
                <th>Adet</th>
                <th>Birim Fiyat</th>
                <th>Toplam</th>
            </tr>
        </thead>

        <tbody>

            <!-- sessionScope.cart artık direkt LIST -->
            
				<c:forEach var="item" items="${sessionScope.cart.items}">
                <!-- Satır toplamı -->
                <c:set var="rowTotal"
                       value="${item.product.price * item.quantity}" />

                <!-- Genel toplam -->
                <c:set var="totalPrice"
                       value="${totalPrice + rowTotal}" />

                <tr>
                    <td>${item.product.name}</td>

                    <td>${item.quantity}</td>

                    <td>
                        ${item.product.price} TL
                    </td>

                    <td>
                        ${rowTotal} TL
                    </td>
                </tr>

            </c:forEach>

        </tbody>

        <tfoot>
            <tr class="table-secondary">
                <td colspan="3" class="text-end">
                    <strong>Genel Toplam:</strong>
                </td>

                <td>
                    <strong>${totalPrice} TL</strong>
                </td>
            </tr>
        </tfoot>

    </table>

    <!-- Adres Formu -->
    <div class="card shadow-sm mt-4">

        <div class="card-body">

            <h4 class="mb-3">Teslimat Bilgileri</h4>

            <form action="checkout" method="post">

                <div class="mb-3">

                    <label class="form-label">
                        Teslimat Adresi
                    </label>

                    <textarea
                            name="address"
                            class="form-control"
                            rows="4"
                            required
                            placeholder="Lütfen açık adresinizi yazınız..."></textarea>

                </div>

                <div class="d-grid">

                    <button type="submit"
                            class="btn btn-success btn-lg">

                        Siparişi Onayla ve Bitir

                    </button>

                </div>

            </form>

        </div>

    </div>

</body>
</html>