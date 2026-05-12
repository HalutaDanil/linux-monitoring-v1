<div align="center">

# Linux Monitoring v1.0

**[English](#english) | [Русский](#русский)**

</div>

---

<a name="english"></a>
## 🇬🇧 English

A step-by-step evolution of bash scripting skills through building a system information tool. Each version adds new concepts — from a simple script to a modular, configurable, and colorized monitoring utility.

### What was done

| Version | What & Why |
|---------|-----------|
| 01 | Basic script outputting hostname, timezone, user, OS, date, uptime, IP, mask, gateway, RAM, and disk usage. Learned how to extract system info with standard utilities. |
| 02 | Split the script into modules (`os.sh`, `timezone.sh`, `memory.sh`, `network.sh`, `uptime.sh`, `assembl_output.sh`). Practiced decomposition and sourcing in bash. |
| 03 | Added color formatting via ANSI escape codes. Made the output readable and visually structured. |
| 04 | Introduced a `script.conf` configuration file for customizing colors without editing the script. Learned config-driven behavior. |
| 05 | Added the ability to save output to a timestamped file (`DD_MM_YY_HH_MM_SS.status`). Useful for logging and audits. |

### Key takeaways
- Bash scripts can be **modular and maintainable** when decomposed properly.
- **Configuration files** make tools flexible without code changes.
- Colorized terminal output significantly improves **readability** of system data.

### Tech Stack

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)

---

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&color=0:58a6ff,50:1f6feb,100:0969da&height=2&section=header&text=&fontSize=1"/>
</div>

<a name="русский"></a>
## 🇷🇺 Русский

Постепенное развитие навыков bash-скриптинга через создание утилиты для сбора системной информации. Каждая версия добавляет новые концепции — от простого скрипта до модульной, настраиваемой и цветной утилиты мониторинга.

### Что было сделано

| Версия | Что и зачем |
|--------|-------------|
| 01 | Базовый скрипт, выводящий hostname, timezone, пользователя, ОС, дату, uptime, IP, маску, шлюз, RAM и диск. Научился доставать системную информацию стандартными утилитами. |
| 02 | Разделение скрипта на модули (`os.sh`, `timezone.sh`, `memory.sh`, `network.sh`, `uptime.sh`, `assembl_output.sh`). Практика декомпозиции и `source` в bash. |
| 03 | Добавлено цветное форматирование через ANSI escape-коды. Вывод стал читаемым и визуально структурированным. |
| 04 | Введён конфигурационный файл `script.conf` для кастомизации цветов без правки скрипта. Изучено конфиг-управляемое поведение. |
| 05 | Добавлено сохранение вывода в файл с timestamp (`DD_MM_YY_HH_MM_SS.status`). Полезно для логирования и аудита. |

### Ключевые выводы
- Bash-скрипты могут быть **модульными и поддерживаемыми** при правильной декомпозиции.
- **Конфигурационные файлы** делают инструменты гибкими без изменения кода.
- Цветной вывод в терминале существенно улучшает **читаемость** системных данных.

### Стек технологий

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)

---

<div align="center">

*Project from portfolio | Проект из портфолио*

</div>
