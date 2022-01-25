#5.2. Применение принципов IaaC в работе с виртуальными машинами

## Задача 1

Опишите своими словами основные преимущества применения на практике IaaC паттернов.

    - минимизируется ручное редактирование конфигураций на серверах
    - минимизируется время для исправления проблем в инфраструктуре, потому что применяются шаблоны
    - стандартизация откатов изменений, их быстрота при выявлении дефектов
    - автоматизация релизов и изменений
    - низкие затраты на обслуживание и конфигурацию инфраструктуры

Какой из принципов IaaC является основополагающим?

    Управление инфраструктурой фактически осуществляется с помощью конфигурационных файлов на Ansible или 
    Vagrant или другими инструментами. Их реализайия приводит к идемпотентности, т.е. ожидаемой "одинаковости"
    конфигурации инфраструктуры. 

## Задача 2


Чем Ansible выгодно отличается от других систем управление конфигурациями?

    Использование существующей ssh-инфраструктуры. Не требует установки программного клиента/агента на 
    таргет хостах.

Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

    Более прост и надежен метод push. На мой взгляд, конфигурацию под такой метод
    проще создавать.

## Задача 3

Установить на личный компьютер:

- VirtualBox
- Vagrant
- Ansible

Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

*VirtualBox*

    PS C:\Program Files\Oracle\VirtualBox> .\VBoxManage.exe -version
    6.1.28r147628

*Vagrant*

    PS C:\Program Files\Oracle\VirtualBox> vagrant -v
    Vagrant 2.2.19

*Ansible*
    
    oleg@DESKTOP-GFD5IMG:~$ ansible --version
    ansible [core 2.12.1]
    config file = /etc/ansible/ansible.cfg
    configured module search path = ['/home/oleg/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
    ansible python module location = /usr/lib/python3/dist-packages/ansible
    ansible collection location = /home/oleg/.ansible/collections:/usr/share/ansible/collections
    executable location = /usr/bin/ansible
    python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
    jinja version = 2.10.1
    libyaml = True

## Задача 4

Воспроизвести практическую часть лекции самостоятельно.

-    Создать виртуальную машину.
-    Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

    docker ps

    vagrant@server1:~$ docker ps
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES



