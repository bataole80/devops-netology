Домашнее задание к занятию "3.5. Файловые системы"

1 . Узнайте о sparse (разряженных) файлах.

Разрежённый файл (англ. sparse file) — файл, в котором последовательности нулевых байтов[1] заменены на информацию об этих последовательностях (список дыр).
Преимущества:

- экономия дискового пространства. Использование разрежённых файлов считается одним из способов сжатия данных на уровне файловой системы;
- отсутствие временных затрат на запись нулевых байт;
    увеличение срока службы запоминающих устройств.

Недостатки:

- накладные расходы на работу со списком дыр;
- фрагментация файла при частой записи данных в дыры;
- невозможность записи данных в дыры при отсутствии свободного места на диске;
- невозможность использования других индикаторов дыр, кроме нулевых байт.

Разрежённые файлы используются для хранения контейнеров, например:

- образов дисков виртуальных машин;
- резервных копий дисков и/или разделов, созданных спец. ПО.
    
Создание разрежённого файла размером 200 Гб:

    dd if=/dev/zero of=./sparse-file bs=1 count=0 seek=200G
    
    
2 . Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Нет. Жесткие ссылки указывает на тот же inode, а эта информация содержится в inode. Права доступа и владелец одни и те же. Жесткие ссылки создаются, когда пользователь уже является владелбцем файла.
Но есть одно - насколько я понимаю, можно модифицировать следующий параметр - /proc/sys/fs/protected_hardlinks для обхода этого правила. Но это означает потенциальные проблемы с безопасностью.
Так лучше не делать.

3 . Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим.
Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

    PS C:\Users\Oleg\Documents\TRAINING\DEVOPS\NETOLOGY\vagrantfiles> vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    ==> default: Importing base box 'bento/ubuntu-20.04'...
    ==> default: Matching MAC address for NAT networking...
    ==> default: Checking if box 'bento/ubuntu-20.04' version '202107.28.0' is up to date...
    ==> default: Setting the name of the VM: vagrantfiles_default_1637874796842_16910
    ==> default: Clearing any previously set network interfaces...
    ==> default: Preparing network interfaces based on configuration...
        default: Adapter 1: nat
    ==> default: Forwarding ports...
        default: 22 (guest) => 2222 (host) (adapter 1)
    ==> default: Running 'pre-boot' VM customizations...
    ==> default: Booting VM...
    ==> default: Waiting for machine to boot. This may take a few minutes...
        default: SSH address: 127.0.0.1:2222
        default: SSH username: vagrant
        default: SSH auth method: private key
        default:
        default: Vagrant insecure key detected. Vagrant will automatically replace
        default: this with a newly generated keypair for better security.
        default:
        default: Inserting generated public key within guest...
        default: Removing insecure key from the guest if it's present...
        default: Key inserted! Disconnecting and reconnecting using new SSH key...
    ==> default: Machine booted and ready!
    ==> default: Checking for guest additions in VM...
    ==> default: Mounting shared folders...
        default: /vagrant => C:/Users/Oleg/Documents/TRAINING/DEVOPS/NETOLOGY/vagrantfiles
        
4 . Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

    Command (m for help): p
    Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x0466959d
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdb1          2048 4196351 4194304    2G 83 Linux
    /dev/sdb2       4196352 5242879 1046528  511M 83 Linux
    
    Command (m for help):
    
5 . Используя sfdisk, перенесите данную таблицу разделов на второй диск.

    vagrant@vagrant:~$ sudo sfdisk -d /dev/sdb > partitions
    vagrant@vagrant:~$ less partitions
    vagrant@vagrant:~$ sudo sfdisk /dev/sdc < partitions
    Checking that no-one is using this disk right now ... OK
    
    Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Created a new DOS disklabel with disk identifier 0x0466959d.
    /dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
    /dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
    /dev/sdc3: Done.
    
    New situation:
    Disklabel type: dos
    Disk identifier: 0x0466959d
    
    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdc1          2048 4196351 4194304    2G 83 Linux
    /dev/sdc2       4196352 5242879 1046528  511M 83 Linux
    
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.
    
    vagrant@vagrant:~$ lsblk -f
    NAME                 FSTYPE      LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
    sda
    ├─sda1               vfat              7D3B-6BE4                                 511M     0% /boot/efi
    ├─sda2
    └─sda5               LVM2_member       Mx3LcA-uMnN-h9yB-gC2w-qm7w-skx0-OsTz9z
      ├─vgvagrant-root   ext4              b527b79c-7f45-4e2b-a90f-1a4e9cb477c2     56.7G     2% /
      └─vgvagrant-swap_1 swap              fad91b1f-6eed-4e4b-8dbf-913ba5bcacc7                  [SWAP]
    sdb
    ├─sdb1
    └─sdb2
    sdc
    ├─sdc1
    └─sdc2
    
    
6 . Соберите mdadm RAID1 на паре разделов 2 Гб.

    vagrant@vagrant:~$ sudo mdadm --create --verbose /dev/md0 --level=mirror --raid-devices=2 /dev/sdb1 /dev/sdc1
    mdadm: Note: this array has metadata at the start and
        may not be suitable as a boot device.  If you plan to
        store '/boot' on this device please ensure that
        your boot-loader understands md/v1.x metadata, or use
        --metadata=0.90
    mdadm: size set to 2094080K
    Continue creating array? yes
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md0 started.
    vagrant@vagrant:~$ cat /proc/mdstat
    Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
    md0 : active raid1 sdc1[1] sdb1[0]
          2094080 blocks super 1.2 [2/2] [UU]
    
    unused devices: <none>
    
7 . Соберите mdadm RAID0 на второй паре маленьких разделов.

    vagrant@vagrant:~$ sudo mdadm --create --verbose /dev/md1 --level=stripe --raid-devices=2 /dev/sdb2 /dev/sdc2
    mdadm: chunk size defaults to 512K
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md1 started.
    vagrant@vagrant:~$
    vagrant@vagrant:~$
    vagrant@vagrant:~$
    vagrant@vagrant:~$ cat /proc/mdstat
    Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
    md1 : active raid0 sdc2[1] sdb2[0]
          1042432 blocks super 1.2 512k chunks
    
    md0 : active raid1 sdc1[1] sdb1[0]
          2094080 blocks super 1.2 [2/2] [UU]
    
    unused devices: <none>
    vagrant@vagrant:~$
    
8 . 
