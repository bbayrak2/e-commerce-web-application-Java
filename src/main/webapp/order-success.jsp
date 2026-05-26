<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Sipariş Başarılı</title>
    
    <meta http-equiv="refresh" content="3;url=home">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">

    <div class="text-center p-5 bg-white shadow-sm rounded border">
        <div class="mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-check-circle-fill text-success" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
            </svg>
        </div>
        
        <h2 class="text-success mb-3">Siparişiniz Başarıyla Alındı!</h2>
        <p class="lead text-muted">Bizi tercih ettiğiniz için teşekkür ederiz.</p>
        
        <hr class="my-4">
        
        <p class="mb-4">
            <strong>3 saniye</strong> içinde ana sayfaya yönlendiriliyorsunuz...
        </p>
        
        <div class="spinner-border text-success mb-4" role="status" style="width: 2rem; height: 2rem;">
            <span class="visually-hidden">Yükleniyor...</span>
        </div>
        
        <br>
        
        <a href="home" class="btn btn-outline-success px-4 rounded-pill">Beklemek İstemiyorum</a>
    </div>

</body>
</html>