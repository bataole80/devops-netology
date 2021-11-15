Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

1 . Установите средство виртуализации Oracle VirtualBox

![OracleVM](OracleVM.jpg)

2 . Установите средство автоматизации Hashicorp Vagrant

![Vagrant](Vagrant.jpg)

3 . В вашем основном окружении подготовьте удобный для дальнейшей работы терминал.

![Windows Terminal](WTerminal.jpg)

4 . С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant

![vm](vm.jpg)

5 . Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, 
которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

![vm1](vm1.jpg)

1024 MB of base memory, 2 CPUs, 4 MB of video memory, 1 monitor with a VboxVGA graphics controller, 
64 GB of virtual disk space

6 . Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

Using two parameters - v.memory and v.cpus like in the example in the documentation:

config.vm.provider "virtualbox" do |v|  
v.memory = 1024  
v.cpus = 2
 end
 
7 . Команда vagrant ssh из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.
 
 ![7](7.jpg)
 
8 . Ознакомиться с разделами man bash, почитать о настройках самого bash:

- какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?
- что делает директива ignoreboth в bash?

The question is actually not clearly defined - did you mean the command or the history file? Anyway, these are the two variables from man

HISTSIZE, line 630-632

HISTFILESIZE, line 621-624

ignoreboth -->
HISTCONTROL
A  colon-separated list of values controlling how commands are saved on the history list.  **If the list of 
values includes ignorespace, lines which begin with a space character are not saved in the history list.  
A value of ignoredups causes lines matching the previous history entry to not be saved.  
A value of ignoreboth is shorthand for ignorespace and ignoredups.** 

In short, ignoreboth does not save both duplicates and lines beginning with a space character.

9 . В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?

{ list; }
list  is  simply executed in the current shell environment.  list must be terminated with a newline or 
semicolon.  This is known as a group command.  The return status is the exit status of list.  Note that 
unlike the metacharacters ( and ), { and } are reserved words and must occur where a reserved word 
is permitted to be recognized.  Since they do not  cause  a  word  break, they must be separated 
from list by whitespace or another shell metacharacter.
lines 206-210

name () compound-command [redirection]
function name [()] compound-command [redirection]
This  defines a function named name.  The reserved word function is optional.  If the function reserved word 
is supplied, the parentheses are optional.  The body of the function is the compound command 
compound-command (see Compound Commands above).  That command is usually a list of commands between { and }, 
but may be any command listed under Compound Commands above,  with one  exception: If the function 
reserved word is used, but the parentheses are not supplied, the braces are required.
lines 307-311

BASH_LINENO
An  array  variable  whose  members  are  the line numbers in source files where each corresponding 
member of FUNCNAME was invoked.  ${BASH_LINENO[$i]} is the line number in the source file
(${BASH_SOURCE[$i+1]}) where ${FUNCNAME[$i]} was called (or ${BASH_LINENO[$i-1]} if referenced within 
another shell function).  Use LINENO to obtain the current line number.
lines 470-472

Not sure if I understood the question.  It is too generic a question.

10 . С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

      vagrant@vagrant:~/files$ touch {1..100000}.txt

      vagrant@vagrant:~/files$ ls -1 | wc -l
      100000

      vagrant@vagrant:~/files$ touch {1..300000}.txt
      -bash: /usr/bin/touch: Argument list too long

The reason is that the number of files to be expanded as arguments is larger than the arguments buffer space, 
managed by the ARG_MAX argument. This limit for the length of a command is imposed by the operating system.

11 . В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]

The conditional expression will return true if the file /tmp exists and is a directory, otherwise it will return false.

12 . Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:
      
      bash is /tmp/new_path_directory/bash
      bash is /usr/local/bin/bash
      bash is /bin/bash

      vagrant@vagrant:~/files$ mkdir /tmp/new_path_directory/
      vagrant@vagrant:~/files$ touch /tmp/new_path_directory/bash
      vagrant@vagrant:~/files$ PATH=/tmp/new_path_directory:$PATH
      vagrant@vagrant:~/files$ echo $PATH
      /tmp/new_path_directory:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
      vagrant@vagrant:~/files$ chmod u+x /tmp/new_path_directory/bash
      vagrant@vagrant:~/files$ type -a bash
      bash is /tmp/new_path_directory/bash
      bash is /usr/bin/bash
      bash is /bin/bash

13 . Чем отличается планирование команд с помощью batch и at?

 at      executes commands **at a specified time**.
 batch   executes commands **when system load levels permit**; in other words, when the load average drops below 1.5, or the value specified in the invocation of atd.

14 . Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.

      vagrant halt


    








