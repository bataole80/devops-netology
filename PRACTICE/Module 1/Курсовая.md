## Задание

1. Создайте виртуальную машину Linux.
   
 Vagrant файл:

    Vagrant.configure("2") do |config|
     config.vm.define :master do |master|
      master.vm.box = "bento/ubuntu-20.04"
      master.vm.network :private_network, ip: "10.0.0.10"
      master.vm.hostname = "master"
    end

    PS C:\Users\Oleg\Documents\TRAINING\DEVOPS\NETOLOGY\vagrantfiles> vagrant up master
    Bringing machine 'master' up with 'virtualbox' provider...
    ==> master: Importing base box 'bento/ubuntu-20.04'...
    ==> master: Matching MAC address for NAT networking...
    ==> master: Checking if box 'bento/ubuntu-20.04' version '202107.28.0' is up to date...
    ==> master: A newer version of the box 'bento/ubuntu-20.04' for provider 'virtualbox' is
    ==> master: available! You currently have version '202107.28.0'. The latest is version
    ==> master: '202112.19.0'. Run `vagrant box update` to update.
    ==> master: Setting the name of the VM: vagrantfiles_master_1640557631712_53538
    ==> master: Clearing any previously set network interfaces...
    ==> master: Preparing network interfaces based on configuration...
        master: Adapter 1: nat
       master: Adapter 2: hostonly
    ==> master: Forwarding ports...
        master: 22 (guest) => 2222 (host) (adapter 1)
    ==> master: Booting VM...
    ==> master: Waiting for machine to boot. This may take a few minutes...
        master: SSH address: 127.0.0.1:2222
        master: SSH username: vagrant
        master: SSH auth method: private key
        master:
       master: Vagrant insecure key detected. Vagrant will automatically replace
      master: this with a newly generated keypair for better security.
       master:
       master: Inserting generated public key within guest...
       master: Removing insecure key from the guest if it's present...
       master: Key inserted! Disconnecting and reconnecting using new SSH key...
    ==> master: Machine booted and ready!
    ==> master: Checking for guest additions in VM...
    ==> master: Setting hostname...
    ==> master: Configuring and enabling network interfaces...
    ==> master: Mounting shared folders...
        master: /vagrant => C:/Users/Oleg/Documents/TRAINING/DEVOPS/NETOLOGY/vagrantfiles

    PS C:\Users\Oleg\Documents\TRAINING\DEVOPS\NETOLOGY\vagrantfiles> vagrant ssh master
    Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage

     System information as of Sun 26 Dec 2021 10:30:06 PM UTC

    System load:  0.09              Processes:             116
    Usage of /:   2.3% of 61.31GB   Users logged in:       0
    Memory usage: 15%               IPv4 address for eth0: 10.0.2.15
    Swap usage:   0%                IPv4 address for eth1: 10.0.0.10


    This system is built by the Bento project by Chef Software
    More information can be found at https://github.com/chef/bento

2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты. 
   
    ```bash
    vagrant@master:~$ sudo apt install ufw
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    ufw is already the newest version (0.36-6).
    0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

    vagrant@master:~$ sudo ufw allow 22
    Rules updated
    Rules updated (v6)
    vagrant@master:~$ sudo ufw allow 443
    Rules updated
    Rules updated (v6)

    vagrant@master:~$ sudo ufw enable
    Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
    Firewall is active and enabled on system startup

    vagrant@master:~$ sudo ufw allow in on lo
    Rule added
    Rule added (v6)

    vagrant@master:~$ sudo ufw reload
    Firewall reloaded
    vagrant@master:~$ sudo ufw status verbose
    Status: active
    Logging: on (low)
    Default: deny (incoming), allow (outgoing), disabled (routed)
    New profiles: skip

    To                         Action      From
    --                         ------      ----
    22                         ALLOW IN    Anywhere
    443                        ALLOW IN    Anywhere
    Anywhere on lo             ALLOW IN    Anywhere
    22 (v6)                    ALLOW IN    Anywhere (v6)
    443 (v6)                   ALLOW IN    Anywhere (v6)
    Anywhere (v6) on lo        ALLOW IN    Anywhere (v6)
   ```

3. Установите hashicorp vault ([инструкция по ссылке](https://learn.hashicorp.com/tutorials/vault/getting-started-install?in=vault/getting-started#install-vault)).
   
```bash
    vagrant@master:~$ vault
    Usage: vault <command> [args]

    Common commands:
    read        Read data and retrieves secrets
    write       Write data, configuration, and secrets
    delete      Delete secrets and configuration
    list        List data or secrets
    login       Authenticate locally
    agent       Start a Vault agent
    server      Start a Vault server
    status      Print seal and HA status
    unwrap      Unwrap a wrapped secret
    ```

4. Cоздайте центр сертификации по инструкции ([ссылка](https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/secrets-management)) и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).
   
```bash
    vagrant@master:~$ export VAULT_ADDR=http://127.0.0.1:8200
    vagrant@master:~$ export VAULT_TOKEN=root
    vagrant@master:~$ ps -eaf | grep vault
    vagrant     2292    2048  0 22:08 pts/1    00:00:01 vault server -dev -dev-root-token-id=root
    vagrant     2319    1338  0 22:10 pts/0    00:00:00 grep --color=auto vault
    
    vagrant@master:~$ vault secrets enable pki
    Success! Enabled the pki secrets engine at: pki/
    vagrant@master:~$ vault secrets tune -max-lease-ttl=2000h pki
    Success! Tuned the secrets engine at: pki/
    vagrant@master:~$ vault write -field=certificate pki/root/generate/internal \
    >      common_name="oleg.batalov.com" \
    >      ttl=2000h > CA_cert.crt

    vagrant@master:~$ vault write pki/config/urls \
    > issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
    > crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
    Success! Data written to: pki/config/urls


    vagrant@master:~$ vault secrets enable -path=pki_int pki
    Success! Enabled the pki secrets engine at: pki_int/
    vagrant@master:~$ vault secrets tune -max-lease-ttl=2000h pki_int
    Success! Tuned the secrets engine at: pki_int/
    vagrant@master:~$ vault write -format=json pki_int/intermediate/generate/internal \
    > common_name="oleg.batalov.com Intermediate Authority" \
    > | jq -r '.data.csr' > pki_intermediate.csr
    vagrant@master:~$ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
    >      format=pem_bundle ttl="2000h" \
    >      | jq -r '.data.certificate' > intermediate.cert.pem
    vagrant@master:~$ vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
    Success! Data written to: pki_int/intermediate/set-signed

    vagrant@master:~$ vault write pki_int/roles/oleg-dot-batalov-dot-com \
    >      allowed_domains="oleg.batalov.com" \
    >      allow_subdomains=true \
    >      max_ttl="720h"
    Success! Data written to: pki_int/roles/oleg-dot-batalov-dot-com

    vagrant@master:~$ vault write pki_int/issue/oleg-dot-batalov-dot-com common_name="test.oleg.batalov.com" ttl="720h"
    Key                 Value
    ---                 -----
ca_chain            [-----BEGIN CERTIFICATE-----
MIIDsDCCApigAwIBAgIUdgul+zU+CABeLLGbh+tsYzhQLoQwDQYJKoZIhvcNAQEL
BQAwGzEZMBcGA1UEAxMQb2xlZy5iYXRhbG92LmNvbTAeFw0yMTEyMjkyMjM2NDVa
Fw0yMjAzMjMwNjM3MTVaMDIxMDAuBgNVBAMTJ29sZWcuYmF0YWxvdi5jb20gSW50
ZXJtZWRpYXRlIEF1dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALJMv3kjjDa1hxJfulX4DHQcjd55aL3ctR91F9cKv/BceM/oqYlqh2xUQEiv
w/yQnGDUm6ckmoKP4AwmySjsccfrtvg7iqbRU80zmNN1fMKoTS7qpdyJpPop/qeC
2CzD03SnOAyssrVOR6W6ogd9vMfGRcPuz/a3XGxecCOWObYmAlOYKHJaJaS5Glqk
h7coXRXiaCuMhWvnEj6GuaCPYOrIM+M7iyICNnXEIKZ+ABAqFc3ab0hbi9vFf4DR
NYoMizh6hOa2XZ8nejyoy9K45VqPrvhBSCj1xvSB3YopgmSjmfueFNueHHpqugcn
89BwVcCRWlPqceZKyXQXxWxQ6k8CAwEAAaOB1DCB0TAOBgNVHQ8BAf8EBAMCAQYw
DwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU9dXocxfOQoSLBy64yBjTB649Hlgw
HwYDVR0jBBgwFoAUgreg6A1lGp31ibWJhZ82zQmuuucwOwYIKwYBBQUHAQEELzAt
MCsGCCsGAQUFBzAChh9odHRwOi8vMTI3LjAuMC4xOjgyMDAvdjEvcGtpL2NhMDEG
A1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6ODIwMC92MS9wa2kvY3Js
MA0GCSqGSIb3DQEBCwUAA4IBAQBcBVZpowbZZdsl1BW1G3CzqN962E29+3Psr/4l
9YV2SrKUl25I1Uew54TMZ+ay9ievQibExjA5TBg/79RgJIFKt/Tdcr3EcqXbtcxw
lOLDAt38Ln8W+wM1fxHU2lL8JoAM9SAE2uktTGvPhFQyFiZO9RbPH4SUYWbhYBk4
H1g+9gNs0PVlRKiN+8BHLD9KpjRGjmR19Iv2kpUDeYOQS90aliJb3I1ZlNcY4g9Q
zkW3NUC9Gwa6Ic3AP/l0UHfAucMKCtfgYYj1wJYrgD9EZhNkS4uFHc5gYGCDQ5M9
I6sxE0TZSUJJdNVqtb70dN1OQw+bkvq2JaLV5j0cg3euy7QJ
-----END CERTIFICATE-----]
certificate         -----BEGIN CERTIFICATE-----
MIIDdTCCAl2gAwIBAgIUcGVhgcgC0w1DLf1LbhlVn6xNpS4wDQYJKoZIhvcNAQEL
BQAwMjEwMC4GA1UEAxMnb2xlZy5iYXRhbG92LmNvbSBJbnRlcm1lZGlhdGUgQXV0
aG9yaXR5MB4XDTIxMTIyOTIyNDI0MVoXDTIyMDEyODIyNDMxMVowIDEeMBwGA1UE
AxMVdGVzdC5vbGVnLmJhdGFsb3YuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAtjqnCPldUYqIK0gAUqUDYP51uP3iJ9UbDWY7LyJ2ZMAVqhnglaUZ
db4ts1LWvR8v8nVV7sk0sP9VBrrWTVBW7CirIkUIViOydGG15XV3ECn9+VbJlCw1
Zu8cxj/xQ+jlSvcNHDF1TRH/A0vzp4sXE+vuULXGIVe5m4yXoe7ETziKX8sh0Htu
+hMLcjqVIYm4GEk5IA4YxtLXaEbhPYAb5csHvkkhKzv5pNDpFU4mElCcE9USnyog
DhArL65kv4lyao7m/a09x9mfeBDUt+u0k5IGKV1d0G+Iv9CdXQP/gJ6Tf71VnDb/
hwy+FowN1feWn8fdHi6NI1wSlsS9+B1WKwIDAQABo4GUMIGRMA4GA1UdDwEB/wQE
AwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwHQYDVR0OBBYEFCTs
LIx2gJeg5NL0vlAfiufp1+dBMB8GA1UdIwQYMBaAFPXV6HMXzkKEiwcuuMgY0weu
PR5YMCAGA1UdEQQZMBeCFXRlc3Qub2xlZy5iYXRhbG92LmNvbTANBgkqhkiG9w0B
AQsFAAOCAQEAHMjpmEzblK8K/GlchTa2hXxHTFjRLrH6tfimzIqdeEPEFno0aw6x
mXtR7F1rXVax/F7BMVX5WFNakc/L9ZoDXL99x/eeOOk0WiUN4AdQNebKf2AT+dwx
y2FfQkD9yLuK09jNLjQTl9XEN1ri3NC9fXqFoaUCFYLA1d1hcWx5Dn+ljbBi8Taq
Lhr44AziDHHHG1P3O8BccgsdvEm9Vice2PzxJOr0dhFiicfCrSmX2wtBw8jrbhCe
aI2CldMU7MtI4E6mnb+nZhXsUgT/pOfDCvdHG0rE86lBkA4VdcOx5ci/kVgrNa36
yNl/LyhfJTidu5I2O5rLF+NOOPGsuX4sgw==
-----END CERTIFICATE-----

```
   
5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.

Корневой сертификат был импортирован в браузер.   

6. Установите nginx.

    ```bash
    vagrant@master:~$ nginx -v
    nginx version: nginx/1.18.0 (Ubuntu)  
    vagrant@master:~$ sudo ufw app list
    Available applications:
      Nginx Full
      Nginx HTTP
      Nginx HTTPS
      OpenSSH

    vagrant@master:~$ systemctl status nginx
    ● nginx.service - A high performance web server and a reverse proxy server
         Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
    Active: active (running) since Wed 2021-12-29 16:14:46 UTC; 6min ago
       Docs: man:nginx(8)
       Main PID: 720 (nginx)
         Tasks: 3 (limit: 1071)
        Memory: 14.3M
        CGroup: /system.slice/nginx.service
                ├─720 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
                ├─721 nginx: worker process
                └─722 nginx: worker process

    Dec 29 16:14:46 master systemd[1]: Starting A high performance web server and a reverse proxy server...
    Dec 29 16:14:46 master systemd[1]: Started A high performance web server and a reverse proxy server.

    vagrant@master:~$ sudo ufw allow 'Nginx Full'
    Rule added
    Rule added (v6)
    vagrant@master:~$ sudo ufw app list
    Available applications:
      Nginx Full
      Nginx HTTP
      Nginx HTTPS
      OpenSSH
    vagrant@master:~$ sudo ufw status
    Status: active

    To                         Action      From
    --                         ------      ----
    22                         ALLOW       Anywhere
    443                        ALLOW       Anywhere
    Anywhere on lo             ALLOW       Anywhere
    Nginx Full                 ALLOW       Anywhere
    22 (v6)                    ALLOW       Anywhere (v6)
    443 (v6)                   ALLOW       Anywhere (v6)
    Anywhere (v6) on lo        ALLOW       Anywhere (v6)
    Nginx Full (v6)            ALLOW       Anywhere (v6)
```

7. По инструкции ([ссылка](https://nginx.org/en/docs/http/configuring_https_servers.html)) настройте nginx на https, используя ранее подготовленный сертификат:
  - можно использовать стандартную стартовую страницу nginx для демонстрации работы сервера;
  - можно использовать и другой html файл, сделанный вами;

    ```bash
    vagrant@master:/var/log/nginx$ cat /etc/nginx/sites-enabled/test.oleg.batalov.com
    server {
        listen 443 ssl default_server;
        ssl_certificate /etc/nginx/certificate/nginx-certificate.crt;
        ssl_certificate_key /etc/nginx/certificate/nginx.key;
        root /var/www/test.oleg.batalov.com/html;
        index index.html index.htm index.nginx-debian.html;
        server_name test.oleg.batalov.com www.test.oleg.batalov.com;
        location / {
                try_files $uri $uri/ =404;
        }
    }

    vagrant@master:/var/log/nginx$ cat /var/www/test.oleg.batalov.com/html/index.html
    <html>
        <head>
            <title>Welcome to my site!</title>
       </head>
        <body>
           <h1>Success!</h1>
       </body>
    </html>

    vagrant@master:/var/log/nginx$ service nginx restart
    ==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
    Authentication is required to restart 'nginx.service'.
    Authenticating as: vagrant,,, (vagrant)
    Password:
    ==== AUTHENTICATION COMPLETE ===
    vagrant@master:/var/log/nginx$ systemctl status nginx.service
    ● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-12-30 22:06:24 UTC; 11s ago
       Docs: man:nginx(8)
    Process: 3090 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 3101 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
      Main PID: 3103 (nginx)
      Tasks: 3 (limit: 1071)
     Memory: 3.4M
     CGroup: /system.slice/nginx.service
             ├─3103 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─3104 nginx: worker process
             └─3105 nginx: worker process

    Dec 30 22:06:24 master systemd[1]: Starting A high performance web server and a reverse proxy server...
    Dec 30 22:06:24 master systemd[1]: Started A high performance web server and a reverse proxy server.
```

8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.
   
![test1](test1.jpg)
![test2](test2.jpg)
![test3](test3.jpg)
![test4](test4.jpg)

9. Создайте скрипт, который будет генерировать новый сертификат в vault:
  - генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
  - перезапускаем nginx для применения нового сертификата.

    ```bash
    #!/usr/bin/bash

    now=$(date +"%m_%d_%Y")

    #set variables
    export VAULT_ADDR=http://127.0.0.1:8200
    export VAULT_TOKEN=root

    if [ -f /etc/nginx/certificate/nginx-certificate.crt ] && [ -f /etc/nginx/certificate/nginx.key ]
    then
            echo "Certificate and key exist, saving the backup"
            if [ -d /etc/nginx/certificate/backup ]
            then
                    echo "Certificate backup directory exists"
            else
                sudo mkdir /etc/nginx/certificate/backup
                echo "Certificate backup directory created"
                sudo cp /etc/nginx/certificate/nginx-certificate.crt /etc/nginx/certificate/backup/nginx-certificate.crt.${now}
                sudo cp /etc/nginx/certificate/nginx.key /etc/nginx/certificate/backup/nginx.key.${now}
            fi
    else
            echo "Certificate and/or key files do not exist"
    fi

    #generate a new certificate
    echo "Create a new certificate and a key"
    vault write pki_int/issue/oleg-dot-batalov-dot-com common_name="test.oleg.batalov.com" ttl="720h" > /tmp/vaultoutput
    sudo chown vagrant:root /etc/nginx/certificate/nginx-certificate.crt
    sudo chown vagrant:root /etc/nginx/certificate/nginx.key
    sudo sed -n '/certificate/,/END CERTIFICATE-----/p' /tmp/vaultoutput | sed 's/^certificate[ \t]*//' > /etc/nginx/certificate/nginx-certificate.crt
    sudo sed -n '/^private_key/,/END RSA PRIVATE KEY-----/p;/END RSA PRIVATE KEY-----/q' /tmp/vaultoutput | sed 's/^private_key[ \t]*//' > /etc/nginx/certificate/nginx.key
    sudo chown root:root /etc/nginx/certificate/nginx-certificate.crt
    sudo chown root:root /etc/nginx/certificate/nginx.key
    #restart nginx service
    echo "Restarting nginx service"
    sudo systemctl restart nginx
    echo "Status of nginx service"
    sudo systemctl status nginx
    ```
    Testing:

    ```bash
    vagrant@master:/etc/nginx/certificate$ ~/cert_script.sh
    Certificate and key exist, saving the backup
    Certificate backup directory exists
    Create a new certificate and a key
    Restarting nginx service
    Status of nginx service
    ● nginx.service - A high performance web server and a reverse proxy server
        Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
        Active: active (running) since Fri 2021-12-31 19:20:16 UTC; 11ms ago
        Docs: man:nginx(8)
        Process: 3674 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
        Process: 3685 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Main PID: 3686 (nginx)
        Tasks: 3 (limit: 1071)
        Memory: 3.4M
        CGroup: /system.slice/nginx.service
                ├─3686 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
                ├─3687 nginx: worker process
                └─3688 nginx: worker process

    Dec 31 19:20:16 master systemd[1]: Starting A high performance web server and a reverse proxy server...
    Dec 31 19:20:16 master systemd[1]: Started A high performance web server and a reverse proxy server.
    ```

![test](test.jpg)


10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

```bash
    
    vagrant@master:/etc/nginx/certificate$ crontab -l
    32 19 31 * * /home/vagrant/cert_script.sh >> /home/vagrant/cert_script.log 2>&1

    vagrant@master:~$ ls -l cert_script.log
    -rw-rw-r-- 1 vagrant vagrant 1165 Dec 31 19:32 cert_script.log
    vagrant@master:~$ cat cert_script.log
    Certificate and key exist, saving the backup
    Certificate backup directory exists
    Create a new certificate and a key
    Restarting nginx service
    Status of nginx service
    ● nginx.service - A high performance web server and a reverse proxy server
        Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
        Active: active (running) since Fri 2021-12-31 19:32:01 UTC; 10ms ago
        Docs: man:nginx(8)
        Process: 3760 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
        Process: 3768 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Main PID: 3770 (nginx)
        Tasks: 3 (limit: 1071)
        Memory: 3.5M
        CGroup: /system.slice/nginx.service
                ├─3770 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
                ├─3771 nginx: worker process
                └─3772 nginx: worker process

    Dec 31 19:32:01 master systemd[1]: Starting A high performance web server and a reverse proxy server...
    Dec 31 19:32:01 master systemd[1]: Started A high performance web server and a reverse proxy server.

    vagrant@master:~$ grep 'Dec 31 19:32' /var/log/syslog
    Dec 31 19:32:01 master CRON[3734]: (vagrant) CMD (/home/vagrant/cert_script.sh >> /home/vagrant/cert_script.log 2>&1)
    Dec 31 19:32:01 master systemd[1]: Stopping A high performance web server and a reverse proxy server...
    Dec 31 19:32:01 master systemd[1]: nginx.service: Succeeded.
    Dec 31 19:32:01 master systemd[1]: Stopped A high performance web server and a reverse proxy server.
    Dec 31 19:32:01 master systemd[1]: Starting A high performance web server and a reverse proxy server...
    Dec 31 19:32:01 master systemd[1]: Started A high performance web server and a reverse proxy server.

```

## Результат

Результатом курсовой работы должны быть снимки экрана или текст:

- Процесс установки и настройки ufw
- Процесс установки и выпуска сертификата с помощью hashicorp vault
- Процесс установки и настройки сервера nginx
- Страница сервера nginx в браузере хоста не содержит предупреждений 
- Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")
- Crontab работает (выберите число и время так, чтобы показать что crontab запускается и делает что надо)