
# Lag en HTML-fil med innholdet til Jovian-siden

$htmlContent = @"
<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Velkommen til Jovian</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        .container {
            background-color: white;
            max-width: 800px;
            margin: auto;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        h1 {
            color: #0055a5;
            margin-bottom: 10px;
        }
        p {
            font-size: 18px;
            margin: 10px 0;
        }
        .infobox {
            background-color: #e6f0ff;
            border-left: 6px solid #0055a5;
            padding: 20px;
            margin: 30px 0;
            text-align: left;
            border-radius: 8px;
        }
        .contact {
            margin-top: 40px;
            font-size: 16px;
            color: #555;
        }
        .footer {
            margin-top: 30px;
            font-size: 14px;
            color: #888;
        }
        a {
            color: #0055a5;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Velkommen til Jovian</h1>
        <p>Du har nå koblet deg til Jovians offisielle IIS-server.</p>
        <div class="infobox">
            <h3>Om Jovian</h3>
            <p><strong>Jovian</strong> er ledende innen teknologi­produksjon i Norge. Vi utvikler fremtidsrettede løsninger som former morgendagens digitale landskap.</p>
        </div>
        <p>Hvis du ser denne siden, fungerer serveren som den skal. 🎉</p>

        <div class="contact">
            <p><strong>Kontakt oss:</strong></p>
            <p>📞 Mobil: +47 123 45 678</p>
            <p>✉️ E-post: <a href="mailto:Jovian@post.com">Jovian@post.com</a></p>
        </div>

        <div class="footer">
            <p>&copy; 2025 Jovian AS – Alle rettigheter reservert</p>
        </div>
    </div>
</body>
</html>
"@

# Skriv HTML-innholdet til fil
$htmlContent | Out-File -FilePath "index.html" -Encoding UTF8

Write-Host "index.html ble opprettet."
