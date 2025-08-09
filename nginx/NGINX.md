
# Quick Commands to Set Up NGINX HTTPS & Reverse Proxy on Server to `localhost:5000`

## 1. Update packages and install NGINX & Certbot

```bash
sudo apt update                  # Update package lists to get latest versions info
sudo apt install nginx certbot python3-certbot-nginx -y  # Install NGINX web server and Certbot for SSL
````

---

## 2. Allow HTTP and HTTPS traffic through firewall (if using UFW)

```bash
sudo ufw allow 'Nginx Full'     # Allow both HTTP (80) and HTTPS (443) traffic through firewall
sudo ufw enable                 # Enable UFW firewall if not already enabled
sudo ufw status                 # Check the status of UFW firewall and its rules
```

---

## 3. Create directory for Certbot challenge files

```bash
sudo mkdir -p /var/www/certbot  # Create directory to store temporary files used to verify domain ownership
```

---

## 4. Obtain SSL certificate (replace your.domain.com)

```bash
sudo certbot certonly --webroot -w /var/www/certbot -d your.domain.com  
# Request an SSL certificate for your domain using webroot verification method
```

---

## 5. Generate Diffie-Hellman parameters (optional but recommended)

```bash
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048  
# Generate strong Diffie-Hellman parameters for enhanced SSL security (may take a few minutes)
```

---

## 6. Place your NGINX config file in `/etc/nginx/sites-available/your.domain.com`

*(Make sure it uses `http://localhost:5000` as your proxy URL)*

---

## 7. Enable your site by linking config

```bash
sudo ln -s /etc/nginx/sites-available/your.domain.com /etc/nginx/sites-enabled/  
# Create a symbolic link to activate your site configuration in NGINX
```

---

## 8. Test NGINX config and reload service

```bash
sudo nginx -t                    # Test NGINX configuration files for syntax errors
sudo systemctl reload nginx      # Reload NGINX to apply new configuration without downtime
```

---

## 9. Check NGINX logs if needed

```bash
sudo tail -f /var/log/nginx/your.domain.com.log  
# Monitor the NGINX access and error logs in real-time for troubleshooting
```

---

## Notes

* Replace `your.domain.com` with your actual domain.
* Make sure your app is running on `http://localhost:5000` before testing.
* Renew certificates automatically via Certbot (usually automatic).

