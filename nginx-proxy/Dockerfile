FROM jwilder/nginx-proxy
RUN { \
  echo 'client_max_body_size      100m;';\
  echo 'proxy_connect_timeout     600;';\
  echo 'proxy_send_timeout        600;';\
  echo 'proxy_read_timeout        600;';\
  echo 'send_timeout              600;';\
} > /etc/nginx/conf.d/my_proxy.conf