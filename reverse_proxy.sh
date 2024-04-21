sudo apt update
sudo apt-get -y install nginx
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get -y install certbot python3-certbot-nginx
sudo apt-get -y install certbot python3-certbot-nginx

echo "This script will create a SSL reverse proxy that points your (sub)domain to an IP with an open port" 

echo "What is the (sub)domain name you want to reverse proxy? (Eg. sub.domain.com)"                                                                                                                   
read ccdomain                                                                                                                                                     
                                                                                                                                                                  
echo "What is the IP address of your server and the port the service is running on (For example 192.168.1.1:8192)"                                                                                   
read ccip                                                                                                                                                         
                                                                                                                                                                  
echo " server {                                                                                                                                                   
        server_name $ccdomain;                                                                                                                                    
        listen 80;                                                                                                                                                
        listen [::]:80;                                                                                                                                           
        access_log /var/log/nginx/reverse-access.log;                                                                                                             
        error_log /var/log/nginx/reverse-error.log;                                                                                                               
        location / {                                                                                                                                              
                    proxy_pass http://$ccip;                                                                                                                      
  }                                                                                                                                                               
} " > /etc/nginx/sites-available/$ccdomain.conf                                                                                                                   
                                                                                                                                                                  
ln -s /etc/nginx/sites-available/$ccdomain.conf /etc/nginx/sites-enabled/$ccdomain.conf                                                                           
                                                                                                                                                                  
certbot --nginx                                                                                                                                                   
                                                                                                                                                                  
echo "Your reverse proxy is now setup and should be available at https://$ccdomain (Is your domain not working? Contact our support at earthhosting.net/tickets" 
