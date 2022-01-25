# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | никакого, переменная не будет определена  |
| Как получить для переменной `c` значение 12?  | c = str(a) + b  |
| Как получить для переменной `c` значение 3?  | c = a + int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:

    #!/usr/bin/env python3

    import os

    bash_command = ["cd ~/devops-netology/", "git status"]
    result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
    for result in result_os.split('\n'):
        if result.find('modified') != -1:
           prepare_result = result.replace('\tmodified:   ', '')
           print(bash_command[0][3:] + '/' + prepare_result)
        

### Вывод скрипта при запуске при тестировании:
    ~/devops-netology/README_python.md
    ~/devops-netology/branching/rebase.sh

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
    #!/usr/bin/env python3

    import os

    repository_path = input("Please enter the absolute repository path: ")
    print("The repository path is ", repository_path)

    if os.path.exists(repository_path) and os.path.isdir(repository_path):
       bash_command = ["cd " + repository_path, "git status"]
      result_os = os.popen(' && '.join(bash_command)).read()
      is_change = False
      for result in result_os.split('\n'):
         if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(bash_command[0][3:] + '/' + prepare_result)

### Вывод скрипта при запуске при тестировании:
    vagrant@master:~$ ./script.py
    Please enter the absolute repository path: /home/vagrant/devops-netology
    The repository path is  /home/vagrant/devops-netology
    /home/vagrant/devops-netology/README_python.md
    /home/vagrant/devops-netology/branching/rebase.sh

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, 
   доступных по http. Мы точно знаем, что на их стенде нет 
   никакой балансировки, кластеризации, за DNS прячется конкретный 
   IP сервера, где установлен сервис. Проблема в том, что отдел, 
   занимающийся нашей инфраструктурой очень часто меняет нам сервера, 
   поэтому IP меняются примерно раз в неделю, при этом сервисы 
   сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, 
   если бы несколько раз сервера не уезжали в такой сегмент 
   сети нашей компании, который недоступен для разработчиков. 
   Мы хотим написать скрипт, который опрашивает веб-сервисы, 
   получает их IP, выводит информацию в стандартный вывод в 
   виде: <URL сервиса> - <его IP>. Также, должна быть 
   реализована возможность проверки текущего IP сервиса c 
   его IP из предыдущей проверки. Если проверка будет провалена - 
   оповестить об этом в стандартный вывод сообщением: 
   [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. 
   Будем считать, что наша разработка реализовала сервисы: 
   `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
    #!/usr/bin/python3

    import socket
    import os

    if os.path.exists('./check'):
        os.rename('./check', './old_check')

    prev_check = {}

    f = open("./check", "w")
    list_of_web_services = ['drive.google.com', 'mail.google.com', 'google.com']
    compare_to_prev_check = input("Do you want to check with the precious result? Please type Y if yes: ")
    if os.path.exists('./old_check') and compare_to_prev_check == 'Y':
        lines = open('./old_check','r').readlines()
        for line in lines:
            prev_check[line.split(" - ")[0]] = line.split(" - ")[1].strip()
        for service in list_of_web_services:
            if prev_check[service] == socket.gethostbyname(service):
                result = service + " - " + socket.gethostbyname(service) + '\n'
                print(result,end=''),
                f.write(result)
            else:
                print("[ERROR] "  + service + " IP mismatch: " + prev_check[service] + ' ' + socket.gethostbyname(service) )

    else:
        print("Previous check file does not exist")
        for service in list_of_web_services:
            result = service + " - " + socket.gethostbyname(service) + '\n'
            print(result,end=''),
            f.write(result)

### Вывод скрипта при запуске при тестировании:
    vagrant@master:~$ ./script1.py
    Do you want to check with the precious result? Please type Y if yes: N
    Previous check file does not exist
    drive.google.com - 142.250.200.46
    mail.google.com - 172.217.169.69
    google.com - 172.217.169.14
    vagrant@master:~$ vi check
    vagrant@master:~$ ./script1.py
    Do you want to check with the precious result? Please type Y if yes: Y
    drive.google.com - 142.250.200.46
    mail.google.com - 172.217.169.69
    [ERROR] google.com IP mismatch: 171.217.169.14 172.217.169.14

