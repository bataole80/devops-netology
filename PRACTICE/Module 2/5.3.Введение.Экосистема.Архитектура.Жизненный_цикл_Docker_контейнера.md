##Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

###Задача 1

Сценарий выполения задачи:

    создайте свой репозиторий на https://hub.docker.com;
    выберете любой образ, который содержит веб-сервер Nginx;
    создайте свой fork образа;
    реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

  <html>
  <head>
  Hey, Netology
  </head>
  <body>
  <h1>I’m DevOps Engineer!</h1>
  </body>
  </html>

Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

    vagrant@server1:~$ sudo docker pull nginx
    Using default tag: latest
    latest: Pulling from library/nginx
    Digest: sha256:2834dc507516af02784808c5f48b7cbe38b8ed5d0f4837f16e78d00deb7e7767
    Status: Image is up to date for nginx:latest
    docker.io/library/nginx:latest
    vagrant@server1:~$ sudo docker tag nginx:latest bataole80/nginx:latest
    vagrant@server1:~$ sudo docker images
    REPOSITORY                        TAG       IMAGE ID       CREATED       SIZE
    bataole80/nginx   latest    c316d5a335a5   12 days ago   142MB
    nginx             latest    c316d5a335a5   12 days ago   142MB
    vagrant@server1:~$ sudo docker push bataole80/nginx
    Using default tag: latest
    The push refers to repository [docker.io/bataole80/nginx]
    762b147902c0: Mounted from library/nginx
    235e04e3592a: Mounted from library/nginx
    6173b6fa63db: Mounted from library/nginx
    9a94c4a55fe4: Mounted from library/nginx
    9a3a6af98e18: Mounted from library/nginx
    7d0ebbe3f5d2: Mounted from library/nginx
    latest: digest: sha256:bb129a712c2431ecce4af8dde831e980373b26368233ef0f3b2bae9e9ec515ee size: 1570
  
    vagrant@server1:~/site-content$ sudo docker ps
    CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS
         NAMES
    2078bc70e984   bataole80/nginx   "/docker-entrypoint.…"   6 seconds ago   Up 6 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   web  

    vagrant@server1:~/site-content$ sudo docker run -it --rm -d -p 8080:80 --name web -v ${PWD}:/usr/share/nginx/html bataole80/nginx
    50921d109519d6e61c8f660eb03833e74baba3d0e4f2fb58519739390b0c98b8
    vagrant@server1:~/site-content$ sudo docker ps
    CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS
         NAMES
    50921d109519   bataole80/nginx   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   web
    vagrant@server1:~/site-content$ sudo wget -qO- 172.17.0.2
    <html>
    <head>
    Hey, Netology
    </head>
    <body>
    <h1>I’m DevOps Engineer!</h1>
    </body>
    </html>

    https://hub.docker.com/repository/docker/bataole80/nginx

###Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

    Высоконагруженное монолитное java веб-приложение;
    Nodejs веб-приложение;
    Мобильное приложение c версиями для Android и iOS;
    Шина данных на базе Apache Kafka;
    Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
    Мониторинг-стек на базе Prometheus и Grafana;
    MongoDB, как основное хранилище данных для java-приложения;
    Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

    Высоконагруженное монолитное java веб-приложение: 
    Контейнеры Docker блищки микросервисной архитектуре, этот подход по сути противостоит концепции 
    монолитной архитектуры. При этом увеличить производительность приложения с помощью контейнеризации 
    не удастся. Мне кажется, в этом сценарии стоит использовать физическую машину.
  
    Nodejs веб-приложение: в данном случае уместно использование docker контейнеров. Их можно запускать 
    на физической или виртуальной машине. В таком случае можно масштабировать приложени при желании. Удобно
    сохранять образ приложения как артефакт.

    Мобильное приложение c версиями для Android и iOS:
    В данном случае целесообразно использование виртуальных машин, если планируется использование
    разных операционных систем. Использование docker контейнеризации не будет эффективным, поскольку
    контейнер возможно запустить только на той операционной системе, в которой он был создан.

    Шина данных на базе Apache Kafka:
    На мой взгляд, не стоит использовать контейнеры для реализации такого сервиса, когда обрабатываются большие объемы 
    данных. Перенос данных из контейнеров непрост. При прекращении работы контейнера будут 
    потеряны все данные, хранящиеся внутри него. Тут стоит использовать кластеры физических машин.

    Elasticsearch кластер для реализации логирования продуктивного веб-приложения - 
    три ноды elasticsearch, два logstash и две ноды kibana:
    Такой кластер можно устанавливать на виртуальные машина, но стоить это будет недешево. Плюс в том, что повышается
    настраиваемость системы. Можно использовать контейнеры docker для уменьшения издержек. Elasticsearch
    доступен в качестве Docker Образов - https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
    
    Мониторинг-стек на базе Prometheus и Grafana:
    Docker-compose позволит быстро собрать мониторинговую систему Prometheus и Grafana, развернуть ее
    с помощью контейнеров. Больше информации здесь: 
    https://grafana.com/docs/grafana-cloud/quickstart/docker-compose-linux/
    Больше тут добавить нечего.

    MongoDB, как основное хранилище данных для java-приложения:
    MongoDB можно запускать как в контейнеризированном состоянии, так и просто на физической и виртуальной 
    машине.     Если данные ценны и их много, я бы не стал использовать контейнеры. Ссылка на использование
    контейнера  - https://docs.mongodb.com/manual/tutorial/install-mongodb-enterprise-with-docker/.
    Если используются контейнеры, то приходится задумываться, где хранить данные, могут быть трудности 
    с их получением из контейнеров.

    Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry:
    Мне кажется, не стоит использовать контейнеры, поскольку для Git lab сервера важна надежность,
    кроме этого, компоненты сервера нуждаются в достаточном количестве ресурсов, что ограничено в docker 
    контейнерах. Я бы использовал физические машины.

###Задача 3

- Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку 
  /data из текущей рабочей директории на хостовой машине в /data контейнера;
- Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из 
  текущей рабочей директории на хостовой машине в /data контейнера;
- Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого 
  содержания в /data;
- Добавьте еще один файл в папку /data на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
    
                       

    ```
    vagrant@server1:~$ sudo docker run -t -i -v /home/vagrant/data:/data centos /bin/bash &
    [2] 25210
    vagrant@server1:~$ sudo docker run -t -i -v /home/vagrant/data:/data debian /bin/bash &
    [3] 30242

    vagrant@server1:~$ sudo docker exec -it 884b32776148 /bin/bash
    [root@884b32776148 /]# ls
    bin  data  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
    [root@884b32776148 /]# cd data
    [root@884b32776148 data]# s
    bash: s: command not found
    [root@884b32776148 data]# ls
    [root@884b32776148 data]# echo 123 > file_centos
    [root@884b32776148 data]# ls
    file_centos
    
    vagrant@server1:~/data$ echo 456 > file_host
    vagrant@server1:~/data$ ls
    file_centos  file_host

    vagrant@server1:~$ sudo docker exec -it 83925844af09 /bin/bash
    root@83925844af09:/# ls
    bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
    root@83925844af09:/# cd data
    root@83925844af09:/data# ls -l
    total 8
    -rw-r--r-- 1 root root 4 Feb  9 22:46 file_centos
    -rw-rw-r-- 1 1000 1000 4 Feb  9 22:48 file_host
    root@83925844af09:/data# cat *
    123
    456
    root@83925844af09:/data#
    
    ```
    


