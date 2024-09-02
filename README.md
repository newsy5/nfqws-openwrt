# nfqws-openwrt (измененная копия [link](https://github.com/Anonym-tsk/nfqws-keenetic) большое спасибо автору)

Скрипты для установки `nfqws` на маршрутизаторы с поддержкой `opkg`.

> **Вы пользуетесь этой инструкцией на свой страх и риск!**
> 
> Автор не несёт ответственности за порчу оборудования и программного обеспечения, проблемы с доступом и потенцией.
> Подразумевается, что вы понимаете, что вы делаете.

Предназначено для роутеров openwrt 

Проверено на маршрутизаторах:

- xiaomi AC2100

Списки проверенного оборудования собираем в [отдельной теме](https://github.com/newsy/nfqws-openwrt/discussions/1).

Поделиться опытом можно в разделе [Discussions](https://github.com/newsy/nfqws-openwrt/discussions) 

### Что это?

`nfqws` - утилита для модификации TCP соединения на уровне пакетов, работает через обработчик очереди NFQUEUE и raw сокеты.

Почитать подробнее можно на [странице авторов](https://github.com/bol-van/zapret) (ищите по ключевому слову `nfqws`).

### Подготовка

- Прошить роутер прошивкой Openwrt

### Автоматическая установка (рекомендуется)

```
opkg install curl
/bin/sh -c "$(curl -fsSL https://github.com/newsy/nfqws-openwrt/raw/master/netinstall.sh)"
```

**Следуйте инструкции установщика:**

1. Выберите архитектуру маршрутизатора `mipsel`, `mips`, `aarch64` или `arm`
> 
2. Введите сетевой интерфейс провайдера, обычно это `wan`. Если ваш провайдер использует PPPoE, ваш интерфейс, скорее всего, `ppp0`.
> Можно указать несколько интерфейсов через пробел (`eth3 nwg1`), например, если вы подключены к нескольким провайдерам
3. Выберите режим работы `auto`, `list` или `all`
> В режиме `list` будут обрабатываться только домены из файла `/opt/etc/nfqws/user.list` (один домен на строку)
>
> В режиме `auto` кроме этого будут автоматически определяться недоступные домены и добавляться в список, по которому `nfqws` обрабатывает трафик. Домен будет добавлен, если за 60 секунд будет 3 раза определено, что ресурс недоступен
>
> В режиме `all` будет обрабатываться весь трафик кроме доменов из списка `/opt/etc/nfqws/exclude.list`
4. Укажите, нужна ли поддержка IPv6
> Если не уверены, лучше не отключайте и оставьте как есть

##### Обновление

Просто запустите установщик еще раз, следуйте инструкциям

```
/bin/sh -c "$(curl -fsSL https://github.com/newsy/nfqws-openwrt/raw/master/netinstall.sh)"
```

##### Автоматическое удаление

```
/bin/sh -c "$(curl -fsSL https://github.com/Anonym-tsk/nfqws-keenetic/raw/master/netuninstall.sh)"
```

### Ручная установка (не рекомендуется, если entware установлен во внутреннюю память)

```
opkg install git git-http curl kmod-ipt-conntrack-extra iptables-mod-conntrack-extra
git clone https://github.com/newsy/nfqws-openwrt.git --depth 1
chmod +x ./nfqws-openwrt/*.sh
./nfqws-openwrt/install.sh
```

##### Обновление

```
cd nfqws-openwrt
git pull --depth=1
./install.sh
```

##### Удаление

```
./nfqws-openwrt/uninstall.sh
```

### Полезное

1. Конфиг-файл `/etc/nfqws/nfqws.conf`
2. Скрипт запуска/остановки `/etc/init.d/S51nfqws {start|stop|restart|reload|status|version}`
3. Вручную добавить домены в список можно в файле `/etc/nfqws/user.list` (один домен на строке, поддомены учитываются автоматически)
4. Автоматически добавленные домены `/etc/nfqws/auto.list`
5. Лог автоматически добавленных доменов `/var/log/nfqws.log`
6. Домены-исключения `/etc/nfqws/exclude.list` (один домен на строке, поддомены учитываются автоматически)
7. Проверить, что нужные правила добавлены в таблицу маршрутизации `iptables-save | grep "queue-num 200"`
> Вы должны увидеть похожие строки (по 2 на каждый выбранный сетевой интерфейс)
> ```
> -A POSTROUTING -o eth3 -p tcp -m tcp --dport 443 -m connbytes --connbytes 1:6 --connbytes-mode packets --connbytes-dir original -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
> ```

### Если ничего не работает...

1. Попробовать разные варианты аргументов nfqws. Для этого в конфиге `/etc/nfqws/nfqws.conf` есть несколько заготовок `NFQWS_ARGS`.

### Частые проблемы
1. `iptables: No chain/target/match by that name`

    Не установлен пакет "Протокол IPv6". Также, проблема может появляться на старых прошивках 2.xx, выключите поддержку IPv6 в конфиге NFQWS
3. Ошибки вида `readlink: not found`, `dirname: not found`

   Обычно возникают не на кинетиках. Решение - установить busybox: `opkg install busybox` или отдельно пакеты `opkg install coreutils-readlink coreutils-dirname`

---

Нравится проект? [Поддержи автора](https://yoomoney.ru/to/410019180291197)! Купи ему немного :beers: или :coffee:!
