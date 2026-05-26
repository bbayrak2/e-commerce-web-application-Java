<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>E-Ticaret | Kayıt Ol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4">Yeni Hesap Oluştur</h3>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                            </div>
                        </c:if>

                        <form action="register" method="post">
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Ad Soyad</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">E-Posta Adresi</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">Şifre</label>
                                <input type="password" class="form-control" id="password" name="password" minlength="6" required>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Telefon Numarası</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>

                            <div class="mb-4">
                                <label for="address" class="form-label">Açık Adres</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-success w-100">Kayıt Ol</button>
                        </form>
                        
                        <div class="text-center mt-3">
                            <p>Zaten bir hesabın var mı? <a href="login.jsp" class="text-decoration-none">Giriş Yap</a></p>
                            <a href="home" class="text-decoration-none text-muted">Ana Sayfaya Dön</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>