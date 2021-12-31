# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис:

    {
    	"info": "Sample JSON output from our service\t",
    	"elements": [{
    		"name": "first",
    		"type": "server",
    		"ip": "71.75.1.1"
    	}, {
    		"name": "second",
    		"type": "proxy",
    		"ip": "71.78.22.43"
    	}]
    }

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
vagrant@master:~$ cat script2.py
#!/usr/bin/python3

import socket
import os
import yaml
import json

format_to_use = input("Do you want to write yaml or json formats, Y or N: ")

check_file = 'yaml_check'
old_check_file = 'yaml_old_check'
if format_to_use == 'Y':
    json_check_file = 'json_check'

if os.path.exists(check_file):
    os.rename(check_file, old_check_file)

check = {}

f = open(check_file, "w")
list_of_web_services = ['drive.google.com', 'mail.google.com', 'google.com']
compare_to_prev_check = input("Do you want to check with the previous result? Please type Y if yes: ")
if os.path.exists(old_check_file) and compare_to_prev_check == 'Y':
    f_old = open(old_check_file)
    prev_check = yaml.load(f_old, Loader=yaml.FullLoader)
    for service in list_of_web_services:
        ip = socket.gethostbyname(service)
        check[service] = socket.gethostbyname(service)
        if prev_check[service] == ip:
            result = service + " - " + socket.gethostbyname(service) + '\n'
            print(result,end=''),
        else:
            print("[ERROR] "  + service + " IP mismatch: " + prev_check[service] + ' ' + ip )
    yaml.dump(check,f)
    f_old.close()

else:
    print("Previous check file does not exist")
    for service in list_of_web_services:
        check[service] = socket.gethostbyname(service)
        print(service + ' - ' + check[service])
    yaml.dump(check,f)
    if format_to_use == 'Y':
        g = open(json_check_file, "w")
        json.dump(check,g)
        g.close()
f.close()
```

### Вывод скрипта при запуске при тестировании:
```
vagrant@master:~$ ./script2.py
Do you want to write yaml or json formats, Y or N: N
Do you want to check with the previous result? Please type Y if yes: N
Previous check file does not exist
drive.google.com - 100.96.115.148
mail.google.com - 100.96.115.149
google.com - 100.96.115.112
vagrant@master:~$ ./script2.py
Do you want to write yaml or json formats, Y or N: Y
Do you want to check with the previous result? Please type Y if yes: Y
drive.google.com - 100.96.115.148
mail.google.com - 100.96.115.149
google.com - 100.96.115.112
vagrant@master:~$ ./script2.py
Do you want to write yaml or json formats, Y or N: Y
Do you want to check with the previous result? Please type Y if yes: Y
drive.google.com - 100.96.115.148
mail.google.com - 100.96.115.149
[ERROR] google.com IP mismatch: 100.96.115.111 100.96.115.112
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
vagrant@master:~$ cat json_check
{"drive.google.com": "100.96.49.90", "mail.google.com": "100.96.49.91", "google.com": "100.96.49.92"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
vagrant@master:~$ cat yaml_check
drive.google.com: 100.96.115.148
google.com: 100.96.115.112
mail.google.com: 100.96.115.149
```

