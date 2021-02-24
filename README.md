# LEDctrl

**LEDctrl** is an app for controlling adressable led strips. Setup different color and effect profiles, switch between them or toggle the lights completely on/off.

For screenshots visit https://lukasfischer.me/ledctrl

-   Create your own color compositions
-   Choose from a selection of images based on your mood
-   Select an effect and configure it to your liking (ping pong, scroboscope, rainbow)

Developed alongside this project was a [Node.js backend](https://github.com/fischi1/LEDctrl-backend) that runs on a Raspberry Pi. The server application receives calls from the app and communicates with [RPI-WS2812-Server](https://github.com/tom-2015/rpi-ws2812-server), a low level application for controlling addressable led strips over a tcp connection.

The app was only tested on android devices.

## Building the app

1. Download and install [Flutter](https://flutter.dev/docs/get-started/install) 1.17.5
    - [Windows](https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.17.5-stable.zip)
    - [macOS](https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.17.5-stable.zip)
    - [Linux](https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.17.5-stable.tar.xz)
2. Install dependencies with `flutter pub get`
3. Generate source files for json serialization with `flutter pub run build_runner build --delete-conflicting-outputs`
4. Run `flutter build apk --release`
5. Done! You can find the built apk under `build\app\outputs\apk\release\app-release.apk`

## Node.js Server

Code and instructions for running the server application on a Raspberry Pi can be found in the repository of the backend application: https://github.com/fischi1/LEDctrl-backend
