## Задача 1

Создать собственный образ операционной системы с помощью Packer.

Для получения зачета, вам необходимо предоставить:
- Скриншот страницы, как на слайде из презентации (слайд 37).

```buildoutcfg
vagrant@server1:/tmp/packer$ ls
docker-centos.pkr.hcl
vagrant@server1:/tmp/packer$ sudo packer init .
vagrant@server1:/tmp/packer$ cat docker-centos.pkr.hcl
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "centos" {
  image  = "centos:centos7"
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.centos"
  ]
}
vagrant@server1:/tmp/packer$ packer fmt .
vagrant@server1:/tmp/packer$ packer validate .
The configuration is valid.
vagrant@server1:/tmp/packer$ sudo packer build docker-centos.pkr.hcl
learn-packer.docker.centos: output will be in this color.

==> learn-packer.docker.centos: Creating a temporary directory for sharing data...
==> learn-packer.docker.centos: Pulling Docker image: centos:centos7
    learn-packer.docker.centos: centos7: Pulling from library/centos
    learn-packer.docker.centos: Digest: sha256:c73f515d06b0fa07bb18d8202035e739a494ce760aa73129f60f4bf2bd22b407
    learn-packer.docker.centos: Status: Image is up to date for centos:centos7
    learn-packer.docker.centos: docker.io/library/centos:centos7
==> learn-packer.docker.centos: Starting docker container...
    learn-packer.docker.centos: Run command: docker run -v /root/.config/packer/tmp3690910797:/packer-files -d -i -t --entrypoint=/bin/sh -- centos:centos7
    learn-packer.docker.centos: Container ID: 462981e8bdfa7b072eeb180981ed4d55d8f2539af3c58c832bfb62f23366a602
==> learn-packer.docker.centos: Using docker communicator to connect: 172.17.0.2
==> learn-packer.docker.centos: Committing the container
    learn-packer.docker.centos: Image ID: sha256:8c8ea3b45d678ca441a7fe3f13ffb923860a7765d60e353425375518ed867f1c
==> learn-packer.docker.centos: Killing the container: 462981e8bdfa7b072eeb180981ed4d55d8f2539af3c58c832bfb62f23366a602
Build 'learn-packer.docker.centos' finished after 9 seconds 757 milliseconds.

==> Wait completed after 9 seconds 757 milliseconds

==> Builds finished. The artifacts of successful builds are:
--> learn-packer.docker.centos: Imported Docker image: sha256:8c8ea3b45d678ca441a7fe3f13ffb923860a7765d60e353425375518ed867f1c
vagrant@server1:/tmp/packer$ sudo docker images
REPOSITORY                        TAG       IMAGE ID       CREATED              SIZE
<none>                            <none>    8c8ea3b45d67   About a minute ago   204MB
bataole80/netology-devops/nginx   latest    c316d5a335a5   6 months ago         142MB
bataole80/nginx                   latest    c316d5a335a5   6 months ago         142MB
nginx                             latest    c316d5a335a5   6 months ago         142MB
debian                            latest    04fbdaf87a6a   6 months ago         124MB
centos                            centos7   eeb6ee3f44bd   10 months ago        204MB
```

## Задача 2

Создать вашу первую виртуальную машину в Яндекс.Облаке.

Для получения зачета, вам необходимо предоставить:
- Скриншот страницы свойств созданной ВМ, как на примере ниже:

<p align="center">
  <img width="1200" height="600" src="./assets/yc_01.png">
</p>

```
Есть известная проблема с аутентификацией/баг при создании образа через Packer в
Амазоне.

Пример:
vagrant@server1:/tmp/packer$ cat aws-centos.pkr.hcl
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "centos" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "eu-west-2"
  source_ami_filter {
    filters = {
      name                = "centos/images/*centos-7-base*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["879147689791"]
  }

  ssh_username = "centos"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.centos"
  ]
}

vagrant@server1:/tmp/packer$ packer build aws-centos.pkr.hcl
learn-packer.amazon-ebs.centos: output will be in this color.

Build 'learn-packer.amazon-ebs.centos' errored after 169 milliseconds 247 microseconds: error validating regions: AuthFailure: AWS was not able to validate the provided access credentials
        status code: 401, request id: f7c9d0f2-e6bd-4e6a-80c8-5c871c382b04

==> Wait completed after 169 milliseconds 304 microseconds

==> Some builds didn't complete successfully and had errors:
--> learn-packer.amazon-ebs.centos: error validating regions: AuthFailure: AWS was not able to validate the provided access credentials
        status code: 401, request id: f7c9d0f2-e6bd-4e6a-80c8-5c871c382b04

==> Builds finished but no artifacts were created.

Разбираюсь с проблемой
```


## Задача 3

Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить:
- Скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже
<p align="center">
  <img width="1200" height="600" src="./assets/yc_02.png">
</p>

## Задача 4 (*)

Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.

Для получения зачета, вам необходимо предоставить:
- Скриншот из Grafana, на котором будут отображаться метрики добавленного вами сервера.
