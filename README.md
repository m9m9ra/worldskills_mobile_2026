<!--
 _____ ______   ________  _____ ______   ________  ________  ________          ________  _______   ___      ___ 
|\   _ \  _   \|\  ___  \|\   _ \  _   \|\  ___  \|\   __  \|\   __  \        |\   ___ \|\  ___ \ |\  \    /  /|
\ \  \\\__\ \  \ \____   \ \  \\\__\ \  \ \____   \ \  \|\  \ \  \|\  \       \ \  \_|\ \ \   __/|\ \  \  /  / /
 \ \  \\|__| \  \|____|\  \ \  \\|__| \  \|____|\  \ \   _  _\ \   __  \       \ \  \ \\ \ \  \_|/_\ \  \/  / / 
  \ \  \    \ \  \  __\_\  \ \  \    \ \  \  __\_\  \ \  \\  \\ \  \ \  \       \ \  \_\\ \ \  \_|\ \ \    / /  
   \ \__\    \ \__\|\_______\ \__\    \ \__\|\_______\ \__\\ _\\ \__\ \__\       \ \_______\ \_______\ \__/ /   
    \|__|     \|__|\|_______|\|__|     \|__|\|_______|\|__|\|__|\|__|\|__|        \|_______|\|_______|\|__|/    
                                                                                                                
--->

# [Worldskills 2026](https://pro.firpo.ru/)  mobile app development 

[![](./assets/publication/matule_preview.png)](https://m9m9ra.github.io)


<!-- ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white) -->
<!-- 
![App Store](https://img.shields.io/badge/App_Store-0D96F6?style=for-the-badge&logo=app-store&logoColor=white)
![Google Pay](https://img.shields.io/badge/GooglePay-%233780F1.svg?style=for-the-badge&logo=Google-Pay&logoColor=white) -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<!-- <a href="">
<img height="36px" src="./assets/publication/test_flight_badge.png"/>
</a>
</br> -->

## О проекте

**Matule 2026** — Требования компетенции (ТК) «Разработка мобильных приложений»
определяют знания, умения, навыки и трудовые функции, которые лежат в
основе наиболее актуальных требований работодателей отрасли.

## Установка

### Требования
- Flutter SDK: ^3.8.1 или выше (до 4.0.0)
- iOS: 17.0+
- Android: 13.0+
- Подключение к интернету для начальной загрузки (опционально).

### Быстрая установка
1. Склонируйте репозиторий:
   ```bash
   git clone https://github.com/m9m9ra/worldskills_mobile_2026.git
   cd worldskills_mobile_2026
   ```
2. Установите зависимости:
   ```bash
   flutter pub get
   ```
3. Запустите приложение:
   ```bash
   flutter run
   ```

## Разработка

### Настройка окружения
- Установите Flutter и настройте эмуляторы или подключите устройство.
- Убедитесь, что у вас есть Xcode (для iOS) и Android SDK (для Android).

### Команды
- **Запуск разработчика:**
  ```bash
  flutter pub run build_runner watch
  ```
- **Сборка:**
  ```bash
  flutter pub run build_runner build
  ```

## Структура папок проекта 

```bash
/lib
│
├── core
│   ├── brand               // Цветовая палитра, константы
│   ├── helpers             // Вспомогательные функции и утилиты
│   ├── router              // Схема навигации
│   └── services            // Сервисы, такие как метрика, уведомления, реклама
│
└── layers                  // Весь бизнес и презентационный слой размещен здесь
    ├── data
    │   ├── local
    │   │   └── sqflite_source.dart
    │   └── remote
    │       └── api.dart
    │
    ├── domain
    │   ├── entities
    │   │   ├── user.dart
    │   │   ├── activity.dart
    │   │   └── ... (другие бизнес-объекты)
    │   ├── repositories (интерфейсы репозиториев)
    │   │   ├── user_repository.dart
    │   │   ├── activity_repository.dart
    │   │   └── ...
    │   └── usecases
    │       ├── activity_usecase.dart
    │       ├── activity_usecase.g.dart
    │       └── ... (другие use case)
    │
    └── presentation
        ├── screens
        │   ├── auth
        │   ├── main
        │   │   ├── activity_screen
        │   │   │   ├── tab_bar
        │   │   │   ├── tabs
        │   │   │   └── view
        │   │   ├── details_screen
        │   │   ├── home_screen
        │   │   ├── profile_screen
        │   │   └── ... (дополнительные экраны)
        │   ├── onboarding
        │   └── other
        │
        └── shared
            ├── store
            │   ├── modules
            │   └── root_store.dart
            └── ui (компоненты общего назначения)
       
└── main.dart

```

### Ошибка подписи
Если есть проблемы с подписью:
```bash
flutter config --clear-ios-signing-cert
```
Затем настройте подпись в VS Code (Settings -> Flutter Guidelines).

## Сообщество
- **Issues**: [Открыть проблему](https://github.com/m9m9ra/worldskills_mobile_2026/issues)
- **Обсуждения**: [GitHub Discussions](https://github.com/m9m9ra/worldskills_mobile_2026/discussions)
- **Контакт**: [m9m9ra.dev](https://m9m9ra.github.io)

---
Copyright (c) 2026 M9M9Ra