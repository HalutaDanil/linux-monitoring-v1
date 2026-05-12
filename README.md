# Linux Monitoring v1.0

> Bash-скрипты для сбора и отображения системной информации

## О проекте

Набор bash-скриптов для мониторинга системы в реальном времени. Каждая версия добавляет новый функционал — от простого вывода параметров до цветного форматирования и конфигурационных файлов.

## Эволюция скриптов

| Версия | Что добавлено |
|--------|--------------|
| `01` | Базовый вывод: hostname, timezone, user, OS, date, uptime |
| `02` | Модульная архитектура: разделение на `os.sh`, `timezone.sh`, `memory.sh`, `network.sh`, `uptime.sh` |
| `03` | Цветное форматирование вывода |
| `04` | Конфигурационный файл `script.conf` для кастомизации |
| `05` | Сохранение данных в файл с timestamp |

## Архитектура (версия 02+)

```
main.sh
├── os.sh          → Информация об ОС
├── timezone.sh    → Часовой пояс и время
├── memory.sh      → RAM (total/used/free)
├── network.sh     → IP, hostname
├── uptime.sh      → Время работы системы
└── assembl_output.sh → Сборка финального вывода
```

## Пример вывода

```
HOSTNAME        = ubuntu-server
TIMEZONE        = Europe/Moscow UTC +3
USER            = aemonhul
OS              = Ubuntu 20.04.6 LTS
DATE            = 2024-01-15 14:32:10
UPTIME          = 3 days, 4 hours, 12 minutes
IP              = 192.168.1.100
MASK            = 255.255.255.0
GATEWAY         = 192.168.1.1
RAM_TOTAL       = 7.7 GB
RAM_USED        = 2.1 GB
RAM_FREE        = 5.6 GB
SPACE_ROOT      = /  98.3 GB
SPACE_ROOT_USED = 23.1 GB
SPACE_ROOT_FREE = 75.2 GB
```

## Технологии

- **Bash** — чистый shell scripting
- **Стандартные утилиты** — `hostnamectl`, `timedatectl`, `free`, `df`, `ip`, `uptime`

---

*Проект из портфолио*
