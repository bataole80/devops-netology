Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1 . Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, что strace выдаёт результат своей работы в поток stderr, а не в stdout.

    chdir("/tmp")

2 . Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
    
    vagrant@netology1:~$ file /dev/tty
    /dev/tty: character special (5/0)
    vagrant@netology1:~$ file /dev/sda
    /dev/sda: block special (8/0)
    vagrant@netology1:~$ file /bin/bash
    /bin/bash: ELF 64-bit LSB shared object, x86-64
    
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.
    
    /usr/share/misc/magic.mgc

3 . Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

Найти файловый дескриптор, который содержит данные того файла, линк к inode которого был удален:

    lsof -p <pid> | grep <file name>
    
Посмотреть его в /proc:

    ls /proc/<pid>/fd/<file descriptor>

Обнулить файл

    > /proc/<pid>/fd/<file descriptor>

4 . Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

Зомби процессы занимают очень небольшое количество памяти, память содержит процессный дескриптор. 
Никакие другие ресурсы не используются. Однако, их опасность в том, что они занимают процессный id, а их в Линуксе ограниченное количество.

5 . В iovisor BCC есть утилита opensnoop:
    
    root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
    
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.

Список файлов приведен ниже

    vagrant@vagrant:/usr/sbin$ sudo ./opensnoop-bpfcc -d 1
    PID    COMM               FD ERR PATH
    779    vminfo              5   0 /var/run/utmp
    575    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
    575    dbus-daemon        18   0 /usr/share/dbus-1/system-services
    575    dbus-daemon        -1   2 /lib/dbus-1/system-services
    575    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/

6 . Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

    uname({sysname="Linux", nodename="vagrant", ...}) = 0

    Part of the utsname information is also accessible via
         /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}.

7 . Чем отличается последовательность команд через ; и через && в bash? Например:
    
    root@netology1:~# test -d /tmp/some_dir; echo Hi
    Hi
    root@netology1:~# test -d /tmp/some_dir && echo Hi
    root@netology1:~#
    
В первом примере команда echo будет выполнена вне зависимости от команды test. ; маркирует последовательность команд.
Во втором примере команда echo будет выполнена только при условии выполнения первой команды с кодом 0. То есть, оператор && это логическое AND.

Есть ли смысл использовать в bash &&, если применить set -e?
Смысл есть, поскольку они используются немного для разных ситуаций. В конструкции с && вторая команда будет выполнена при условии успешности первой.
set -e останавливает действие скрипта, если первая команда завершается с ошибкой. 

8 .  Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

Опции данного режима приближают язык командной оболочки к возможностям языка программирования.

set -e - если строка скрипта завершается неуспешно, исполнение скрипта останавливается

set -u - если встречается ошибка с переменной, скрипт завершается

set -x - печать или вывод trace команд перед их выполнением

set -o pipefail - если одна из команд в pipe завершается неуспешно, прекращается исполнение скрипта

9 .  Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
 
       
PROCESS STATE CODES
       Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:

               D    uninterruptible sleep (usually IO)
               I    Idle kernel thread
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent
               
Выдержка из man по значению дополнительных букв или символов

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group
               
    vagrant@vagrant:~$ ps -aux | awk '{print $8}' | sort | uniq -c
      8 I
     40 I<
      1 R+
     24 S
      3 S+
      1 Sl
      1 SLsl
      2 SN
      1 S<s
     14 Ss
      1 Ss+
      5 Ssl
      1 STAT
      
Больше всего процессов high priority в состоянии Idle 




