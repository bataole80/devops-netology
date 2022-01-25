Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1 . Работа c HTTP через телнет.

Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
отправьте HTTP запрос

    GET /questions HTTP/1.0
    HOST: stackoverflow.com
    [press enter]
    [press enter]

    В ответе укажите полученный HTTP код, что он означает?

    HTTP/1.1 301 Moved Permanently

Код состояния HTTP 301 — стандартный код ответа HTTP, получаемый в ответ от сервера в ситуации, когда запрошенный ресурс был на постоянной основе перемещён в новое месторасположение, и указывающий на то, что текущие ссылки, использующие данный URL, должны быть обновлены. 

2 . Повторите задание 1 в браузере, используя консоль разработчика F12.

    откройте вкладку Network
    отправьте запрос http://stackoverflow.com
    найдите первый ответ HTTP сервера, откройте вкладку Headers
    укажите в ответе полученный HTTP код.
    проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
    приложите скриншот консоли браузера в ответ.

![browser2](browser2.jpg)

Код 200 OK

![browser2.1](browser2.1.jpg)

Данный GET запрос в списке, судя по timings консоли, выполнялся дольше всего.

3 . Какой IP адрес у вас в интернете?

![browser3](browser3.jpg)   

4 . Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

    vagrant@vagrant:~$ whois 89.109.51.112
    % This is the RIPE Database query service.
    % The objects are in RPSL format.
    %
    % The RIPE Database is subject to Terms and Conditions.
    % See http://www.ripe.net/db/support/db-terms-conditions.pdf

    % Note: this output has been filtered.
    %       To receive output for a database update, use the "-B" flag.

    % Information related to '89.109.44.0 - 89.109.51.255'

    % Abuse contact for '89.109.44.0 - 89.109.51.255' is 'abuse@rt.ru'

    inetnum:        89.109.44.0 - 89.109.51.255
    netname:        PPPoE-PG-NAT-POOL4
    descr:          Network for PPPoE clients terminations in
    descr:          N.Novgorod city
    country:        RU
    admin-c:        VT-RU
    tech-c:         VT-RU
    status:         ASSIGNED PA
    mnt-by:         MNT-VOLGATELECOM
    created:        2021-05-13T10:00:08Z
    last-modified:  2021-05-13T10:00:08Z
    source:         RIPE

    role:           OJSC Rostelecom, Nizhny Novgorod

IP адрес принадлежит Ростелеком.


% Information related to '89.109.48.0/22AS12389'

route:          89.109.48.0/22
descr:          Rostelecom networks
origin:         AS12389
mnt-by:         MNT-VOLGATELECOM
created:        2021-05-13T10:07:44Z
last-modified:  2021-05-13T10:07:44Z
source:         RIPE

AS номер AS12389.

5 . Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute

    PS C:\Users\Oleg Lon> tracert 8.8.8.8

    Tracing route to dns.google [8.8.8.8]
    over a maximum of 30 hops:

      1     1 ms     1 ms     1 ms  rt [192.168.0.1]
      2     5 ms     2 ms     4 ms  188.254.2.28
      3     2 ms     2 ms     5 ms  188.254.2.29
      4     2 ms     2 ms     2 ms  109.172.24.143
      5     *        *        *     Request timed out.
      6     *        *        *     Request timed out.
      7    11 ms    18 ms    12 ms  108.170.250.130
      8    30 ms     *        *     209.85.255.136
      9    26 ms    26 ms    29 ms  72.14.238.168
     10    27 ms    26 ms    26 ms  172.253.51.245
     11     *        *        *     Request timed out.
     12     *        *        *     Request timed out.
     13     *        *        *     Request timed out.
     14     *        *        *     Request timed out.
     15     *        *        *     Request timed out.
     16     *        *        *     Request timed out.
     17     *        *        *     Request timed out.
     18     *        *        *     Request timed out.
     19     *        *        *     Request timed out.
     20     *        *        *     Request timed out.
     21    32 ms    26 ms     *     dns.google [8.8.8.8]
     22    37 ms    33 ms    26 ms  dns.google [8.8.8.8]

    Trace complete.

Пакет проходит через сети:
- представленные адресами 188.254.2.28, 188.254.2.29: 188.254.0.0/17 AS12389
- 109.172.24.143: 109.172.24.0/24 AS12389
- 108.170.250.130: AS15169
- 209.85.255.136: whois не определил AS, организация Google
- 72.14.238.168: whois не определил AS, организация Google
- 172.253.51.245: 172.253.0.0/16 AS15169

6 . Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?

    vagrant@vagrant:~$ mtr -bzr 8.8.8.8 > MtrReport
    vagrant@vagrant:~$ less MtrReport

    Start: 2021-12-02T13:29:36+0000
    HOST: vagrant                     Loss%   Snt   Last   Avg  Best  Wrst StDev
      1 . AS???    _gateway (10.0.2.2)  0.0%    10    0.5   2.3   0.5  16.6   5.0
      2 . AS???    rt (192.168.0.1)     0.0%    10    3.0   4.6   2.9  13.3   3.1
      3 . AS12389  188.254.2.28         0.0%    10   31.9  19.1   4.8  88.4  26.2
      4 . AS12389  188.254.2.29        30.0%    10    3.8   5.0   3.8  10.8   2.6
      5 . AS12389  109.172.24.143       0.0%    10    5.3   5.1   3.4   7.1   1.3
      6 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      7 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
      8 . AS15169  108.170.250.130      0.0%    10   14.6  15.1  13.9  18.6   1.5
      9 . AS15169  209.85.255.136      60.0%    10   31.6  31.8  31.3  32.9   0.8
     10 . AS15169  72.14.238.168        0.0%    10   28.7  36.1  27.9  91.6  19.8
     11 . AS15169  172.253.51.245       0.0%    10   29.4  29.4  27.9  32.4   1.3
     12 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     13 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     14 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     15 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     16 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     17 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     18 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     19 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     20 . AS???    ???                 100.0    10    0.0   0.0   0.0   0.0   0.0
     21 . AS15169  dns.google (8.8.8.8 90.0%    10   28.3  28.3  28.3  28.3   0.0

Наибольшая задержка на участке AS15169.

7 . Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig

    vagrant@vagrant:~$ dig dns.google

    ; <<>> DiG 9.16.1-Ubuntu <<>> dns.google
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 4996
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;dns.google.                    IN      A

    ;; ANSWER SECTION:
    dns.google.             518     IN      A       8.8.8.8
    dns.google.             518     IN      A       8.8.4.4

    ;; Query time: 12 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53)
    ;; WHEN: Thu Dec 02 13:39:48 UTC 2021
    ;; MSG SIZE  rcvd: 71

8 . Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig

    vagrant@vagrant:~$ dig -x 8.8.8.8

    ; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55852
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;8.8.8.8.in-addr.arpa.          IN      PTR

    ;; ANSWER SECTION:
    8.8.8.8.in-addr.arpa.   1568    IN      PTR     dns.google.

    ;; Query time: 0 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53)
    ;; WHEN: Thu Dec 02 13:46:25 UTC 2021
    ;; MSG SIZE  rcvd: 73

    vagrant@vagrant:~$ dig -x 8.8.4.4

    ; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.4.4
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18533
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;4.4.8.8.in-addr.arpa.          IN      PTR

    ;; ANSWER SECTION:
    4.4.8.8.in-addr.arpa.   2164    IN      PTR     dns.google.

    ;; Query time: 12 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53)
    ;; WHEN: Thu Dec 02 13:46:35 UTC 2021
    ;; MSG SIZE  rcvd: 73

8.8.8.8 --> dns.google.
8.8.4.4 --> dns.google.




