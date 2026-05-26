<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>E-Ticaret | Ana Sayfa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        .product-card { transition: transform 0.2s; }
        .product-card:hover { transform: scale(1.03); box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .product-img { height: 200px; object-fit: cover; }
    </style>
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">🛒 E-Ticaret Portalı</a>
            
            <div class="d-flex align-items-center text-white">
                <c:choose>
                    <%-- Giriş Yapılmışsa --%>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <span class="me-3">Hoş geldin, <b>${sessionScope.loggedInUser.fullName}</b></span>
                        
                        <c:if test="${sessionScope.loggedInUser.role == 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin-orders" class="btn btn-danger btn-sm me-2">Yönetim Paneli</a>
                        </c:if>
                        
                        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-light btn-sm me-2">📦 Siparişlerim</a>
                        <a href="${pageContext.request.contextPath}/cart.jsp" class="btn btn-warning btn-sm me-2">🛒 Sepetim</a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary btn-sm">Çıkış Yap</a>
                    </c:when>
                    
                    <%-- Ziyaretçi İse --%>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-light btn-sm me-2">Giriş Yap</a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary btn-sm me-2">Kayıt Ol</a>
                        <a href="${pageContext.request.contextPath}/cart.jsp" class="btn btn-warning btn-sm">🛒 Sepetim</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <div class="container">
        
        <div class="row g-3 mb-4 align-items-center bg-white p-3 rounded shadow-sm border">
            
            <div class="col-md-5">
                <form action="${pageContext.request.contextPath}/home" method="get" class="d-flex">
                    <input type="hidden" name="category" value="${param.category}">
                    <input type="text" name="search" class="form-control me-2" placeholder="Ürün adı ara..." value="${selectedSearch}">
                    <button type="submit" class="btn btn-primary">🔍 Ara</button>
                    
                    <c:if test="${not empty selectedSearch || (not empty selectedCategory && selectedCategory != 'Genel')}">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary ms-2">Sıfırla</a>
                    </c:if>
                </form>
            </div>

            <div class="col-md-7 d-flex justify-content-md-end gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/home?category=Genel&search=${selectedSearch}" 
                   class="btn btn-sm ${empty selectedCategory || selectedCategory == 'Genel' ? 'btn-dark' : 'btn-outline-dark'}">Genel</a>
                   
                <a href="${pageContext.request.contextPath}/home?category=Elektronik&search=${selectedSearch}" 
                   class="btn btn-sm ${selectedCategory == 'Elektronik' ? 'btn-dark' : 'btn-outline-dark'}">Elektronik</a>
                   
                <a href="${pageContext.request.contextPath}/home?category=Giyim&search=${selectedSearch}" 
                   class="btn btn-sm ${selectedCategory == 'Giyim' ? 'btn-dark' : 'btn-outline-dark'}">Giyim</a>
                   
                <a href="${pageContext.request.contextPath}/home?category=Kitap&search=${selectedSearch}" 
                   class="btn btn-sm ${selectedCategory == 'Kitap' ? 'btn-dark' : 'btn-outline-dark'}">Kitap</a>
                   
                <a href="${pageContext.request.contextPath}/home?category=Ev %26 Yaşam&search=${selectedSearch}" 
                   class="btn btn-sm ${selectedCategory == 'Ev & Yaşam' ? 'btn-dark' : 'btn-outline-dark'}">Ev & Yaşam</a>
            </div>
        </div>

        <h2 class="text-center mb-4">
            ${not empty selectedCategory && selectedCategory != 'Genel' ? selectedCategory += ' Ürünleri' : 'Öne Çıkan Ürünler'}
        </h2>
        
        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4 mb-4">
                    <div class="card product-card h-100">
                        <img src="${product.imageUrl != null && not empty product.imageUrl ? product.imageUrl : 'https://via.placeholder.com/300x200?text=Gorsel+Yok'}" 
                             class="card-img-top product-img p-2" alt="${product.name}">
                        
                        <div class="card-body d-flex flex-column">
                            <span class="badge bg-secondary mb-2 align-self-start">${product.category != null ? product.category : 'Genel'}</span>
                            
                            <h5 class="card-title">${product.name}</h5>
                            <h4 class="text-primary mb-3">${product.price} TL</h4>
                            
                            <c:choose>
                                <c:when test="${product.stock > 0}">
                                    <p class="text-success small">Stokta Var (${product.stock} adet)</p>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-auto">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <button type="submit" class="btn btn-success w-100">Sepete Ekle</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-danger small mt-auto">Stokta Yok</p>
                                    <button class="btn btn-secondary w-100 mt-auto" disabled>Tükendi</button>
                                </c:otherwise>
                            </c:choose>
                            
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty products}">
                <div class="alert alert-warning text-center w-100 py-4 shadow-sm" role="alert">
                    <h5>Aradığınız kriterlere uygun ürün bulunamadı.</h5>
                    <p class="mb-0">Lütfen farklı bir kelime ile aramayı deneyin veya filtreleri sıfırlayın.</p>
                </div>
            </c:if>
        </div>
        
    </div>
 
</body>
</html>