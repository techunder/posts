rm -rf resources
rm -rf public
hugo
ssh -p 6711 root@jser "rm -rf /data/app/nginx/posts/*" 
scp -P6711 -r public/* root@jser:/data/app/nginx/posts/
