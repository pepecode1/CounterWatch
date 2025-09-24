# CounterWatch

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![watchOS](https://img.shields.io/badge/watchOS-10.0+-blue.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Xcode](https://img.shields.io/badge/Xcode-17.0+-green.svg)

CounterWatch es una aplicación para Apple Watch que permite contar personas de forma sencilla, con soporte para gestos de doble toque, retroalimentación háptica, y una complicación para mostrar el conteo en la esfera del reloj. Incluye una app companion para iPhone que sincroniza el conteo en tiempo real y muestra un historial. La app utiliza una arquitectura MVVM, App Groups para compartir datos, y WatchConnectivity para la sincronización entre dispositivos.

## Características

- **Contador en Apple Watch**:
  - Incrementa y decrementa el conteo con botones en pantalla.
  - Soporta el gesto de doble toque físico (`handGestureShortcut`) en Apple Watch Series 9+ con watchOS 10+.
  - Retroalimentación háptica con `WKInterfaceDevice` (`.click` para conteos, `.notification` para múltiplos del intervalo configurado).
  - Configuración de intervalos de alerta (e.g., cada 10 personas) usando botones.

- **Complicación**:
  - Muestra el conteo actual en la esfera del reloj (familias: `.accessoryCircular`, `.accessoryCorner`, `.accessoryRectangular`).
  - Actualizada mediante WidgetKit y App Groups.

- **App de iPhone**:
  - Muestra el conteo actual y un historial de conteos.
  - Permite resetear el conteo en el Watch desde el iPhone.
  - Sincronización en tiempo real con `WatchConnectivity`.

- **Pruebas**:
  - Pruebas unitarias para la lógica del contador (`CounterViewModel`).
  - Pruebas de UI (`XCUITest`) para las interacciones en watchOS e iOS.

## Requisitos

- **Xcode**: 17.0 o superior
- **watchOS**: 10.0 o superior (para gestos de doble toque, requiere Series 9 o Ultra 2)
- **iOS**: 17.0 o superior
- **Dispositivos**:
  - Apple Watch (Series 4 o posterior para watchOS 10; Series 9+ para gestos de doble toque)
  - iPhone compatible con iOS 17+

## Instalación

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/pepecode1/CounterWatch.git
   cd CounterWatch

 ## Capturas de pantalla
 
<img width="206" height="256" alt="Simulator Screenshot - Clone 1 of Apple Watch Series 11 (46mm) - 2025-09-24 at 10 23 29" src="https://github.com/user-attachments/assets/6aa349e8-eb83-4e8f-aaf8-ae6f109268c1" />
<img width="206" height="256" alt="Simulator Screenshot - Clone 1 of Apple Watch Series 11 (46mm) - 2025-09-24 at 10 23 24" src="https://github.com/user-attachments/assets/27b29306-a1fe-4177-9b35-e1fa9f9ee1e7" />
<img width="206" height="256" alt="Simulator Screenshot - Clone 1 of Apple Watch Series 11 (46mm) - 2025-09-24 at 10 23 20" src="https://github.com/user-attachments/assets/aeba9527-cce5-4e20-a3e7-7b35b83d014f" />
<img width="206" height="256" alt="Simulator Screenshot - Clone 1 of Apple Watch Series 11 (46mm) - 2025-09-24 at 10 23 17" src="https://github.com/user-attachments/assets/72ac638a-070b-4265-93dc-2a50259c84d5" />
<img width="204" height="226" alt="Simulator Screenshot - Apple Watch Series 11 (42mm) - 2025-09-21 at 11 14 28" src="https://github.com/user-attachments/assets/6ba39c3d-4366-4d8f-9766-e8c6e242ecbb" />
<img width="204" height="226" alt="Simulator Screenshot - Apple Watch Series 11 (42mm) - 2025-09-21 at 11 14 23" src="https://github.com/user-attachments/assets/18dfac25-0f66-4ff5-b746-89f9b60dc092" />
<img width="204" height="226" alt="Simulator Screenshot - Apple Watch Series 11 (42mm) - 2025-09-21 at 11 14 06" src="https://github.com/user-attachments/assets/8b10c540-323f-46d6-8964-f28524f5b278" />
<img width="204" height="226" alt="Simulator Screenshot - Apple Watch Series 11 (42mm) - 2025-09-21 at 11 14 03" src="https://github.com/user-attachments/assets/0942b765-ca92-42a3-b7bc-d197197218e1" />
