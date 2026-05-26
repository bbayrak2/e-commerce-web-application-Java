<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    // GÜVENLİK: Sadece admin girebilir!
    com.eticaret.model.User user = (com.eticaret.model.User) session.getAttribute("loggedInUser");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp?error=yetkisiz");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Yönetici Paneli</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2>Hoş Geldin Patron!</h2>
    <a href="home" class="btn btn-secondary mb-4">Siteye Dön</a>
	<a href="${pageContext.request.contextPath}/admin-orders" class="btn btn-secondary mb-4" > Siparişler </a>

	<div class="card mb-4 p-4 shadow-sm">
	    <h4>Yeni Ürün Ekle</h4>
	    <form action="${pageContext.request.contextPath}/admin-product" method="post" enctype="multipart/form-data">
	        <div class="row g-3 align-items-end"> <div class="col-md-3">
	                <label class="form-label fw-bold">Ürün Adı</label>
	                <input type="text" name="name" class="form-control" placeholder="Ürün Adı" required>
	            </div>
	            
	            <div class="col-md-2">
	                <label class="form-label fw-bold">Kategori</label>
	                <select name="category" class="form-select" required>
	                    <option value="Elektronik">Elektronik</option>
	                    <option value="Giyim">Giyim</option>
	                    <option value="Kitap">Kitap</option>
	                    <option value="Ev & Yaşam">Ev & Yaşam</option>
	                    <option value="Genel">Genel</option>
	                </select>
	            </div>
	            
	            <div class="col-md-2">
	                <label class="form-label fw-bold">Fiyat (TL)</label>
	                <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00" required>
	            </div>
	            
	            <div class="col-md-1"> <label class="form-label fw-bold">Stok</label>
	                <input type="number" name="stock" class="form-control" placeholder="Adet" required>
	            </div>
	            
	            <div class="col-md-2">
	                <label class="form-label fw-bold">Ürün Görseli</label>
	                <input type="file" name="image" class="form-control" accept="image/*">
	            </div>
	            
	            <div class="col-md-2">
	                <button type="submit" class="btn btn-success w-100">➕ Ürünü Ekle</button>
	            </div>
	            
	        </div>
	    </form>
	</div>
    <div class="card p-4 shadow-sm">
        <h4>📦 Mevcut Ürünler</h4>
        <div class="table-responsive">
            <table class="table table-striped table-hover mt-3 align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Ürün</th>
                        <th>Fiyat</th>
                        <th>Stok</th>
                        <th>İşlemler (Güncelle/Sil)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        com.eticaret.dao.ProductDAO pDao = new com.eticaret.dao.ProductDAO();
                        java.util.List<com.eticaret.model.Product> pList = pDao.getAllProducts();
                        
                        if(pList != null && !pList.isEmpty()) {
                            // DÖNGÜ BAŞLIYOR (p değişkeni burada oluşuyor)
                            for(com.eticaret.model.Product p : pList) {
                    %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td>
                            <img src="<%= p.getImageUrl() %>" width="50" height="50" class="img-thumbnail me-2" onerror="this.src='images/default.jpg'">
                            <%= p.getName() %>
                        </td>
                        <td><%= p.getPrice() %> ₺</td>
                        <td>
                            <span class="badge <%= p.getStock() < 5 ? "bg-danger" : "bg-success" %>">
                                <%= p.getStock() %> Adet
                            </span>
                        </td>
						<td>
						                            <div class="d-flex align-items-center gap-2">
						                                
						                                <form action="${pageContext.request.contextPath}/admin-product" method="post" enctype="multipart/form-data" class="row g-2 align-items-center m-0">
						                                    <input type="hidden" name="id" value="<%= p.getId() %>">
						                                    
						                                    <div class="col-auto">
						                                        <input type="number" step="0.01" name="price" value="<%= p.getPrice() %>" style="width:90px;" class="form-control form-control-sm" placeholder="Fiyat" required>
						                                    </div>
						                                    
						                                    <div class="col-auto">
						                                        <input type="number" name="stock" value="<%= p.getStock() %>" style="width:75px;" class="form-control form-control-sm" placeholder="Stok" required>
						                                    </div>
						                                    
						                                    <div class="col-auto">
						                                        <input type="file" name="image" class="form-control form-control-sm" accept="image/*" style="width:150px;">
						                                    </div>
						                                    
						                                    <div class="col-auto">
						                                        <button type="submit" class="btn btn-sm btn-warning">Güncelle</button>
						                                    </div>
						                                </form>
						                                
						                               <a href="${pageContext.request.contextPath}/admin-product?action=delete&id=<%= p.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Bu ürünü silmek istediğinize emin misiniz?')">Sil</a>
						                            
														
						                            </div>
						                        </td>
                    </tr>
                    <% 
                            } // DÖNGÜ BİTİYOR
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center text-muted">Henüz ürün eklenmemiş veya listelenecek ürün yok.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>