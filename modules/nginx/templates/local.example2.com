server {
        listen   80;
        server_name DOMAIN.COM;

        root   /home/local.example.com/webroot/;

        inder  index.php index.html;
        error_log /var/log/nginx/local.example2.com.error.log;
        access_log /var/log/nginx/local.example2.com.access.log;

        try_files $uri $uri/ /index.php?$args;

        location ~ \.php$
        {
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_index app.php;
                include fastcgi_params;
                fastcgi_param PATH_INFO $fastcgi_path_info;
                fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
        }

        location ~ /\.ht {
                deny all;
        }
}
