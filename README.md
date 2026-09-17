# Equipo2-Cero-Fraude-Aplicacion

Native iOS client for **Cero Fraude**, a fraud-reporting app built for **Red por la Ciberseguridad** built with SwiftUI, communicating with a NestJS REST API backed by MySQL.

## Requirements

- **Xcode 16** or later,
- **iOS 17.0** deployment target,
- An **Apple ID** (personal or team) configured for code signing for running on a physical device.

## Getting the project

```bash
git clone <url>
cd CeroFraude-MobileClient
open CeroFraude-MobileClient.xcodeproj
```

## Running in the simulator

1. In Xcode, select the `CeroFraude-MobileClient` scheme (top toolbar).
2. Choose a Simulator from the device selector (e.g. iPhone 17 Pro).
3. Press `Cmd+R` to build and run.

## Running on a Physical iPhone

1. Connect the iPhone via a data-capable USB-C cable, directly to the Mac, and unlock it.
2. Accept **"Trust This Computer?"** on the iPhone if prompted.
3. On the iPhone: **Settings > Privacy & Security > Developer Mode**, enable it and restart when asked.
4. In the project's **Signing & Capabilities** tab, select a development Team (a personal Apple ID works for local development).
5. Select the physical device from Xcode's device selector and press `Cmd+R`.

## Project structure

```
CeroFraude-MobileClient/
├── Models/
├── Services/
├── ViewModels/
├── Views/
└── Assets.xcassets
```
