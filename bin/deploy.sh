rm -rf resources
rm -rf public
hugo
scp -P6711 -r public/* root@jtest:/data/app/nginx/posts/
