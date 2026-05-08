# Diorite!
## Administrador de Personajes.

[English](../README.md) | Español

---
Diorite es una aplicación que permite crear, editar y consultar personajes. El guardado es de forma local, y está construida pensando en escritores y Roleplayers.

### Características
- Creación de personajes.
- Soporte de Texto Multilíneas.
- Añadir imágenes desde el dispositivo.
- Guardado Local, disponible sin conexión.

### Tecnologías
- #### Dart & Flutter
    - Usamos Flutter con Dart por su filosofía multiplataforma. Por el momento la app está pensada para dispositivos Android, pero gracias a esta decisión será fácilmente porteable a otros sistemas.

### Estado
Primera versión estable: 1.2.6
El proyecto está en contínuno desarrollo, y a la espera de retroalimentación de la comunidad. Por ahora sólo hay una persona trabajando en esto.

### Requisitos
- Flutter SDK
- Dart SDK
- Android SDK
- Git

### Instalación
```bash
git clone ...
cd diorite
flutter pub get
flutter run 
```

### Compilación

Para generar builds de Android es necesario instalar también el SDK de Android y configurar las herramientas de línea de comandos.

El primer paso es descargar las [Android Command-line Tools](https://developer.android.com/tools) y agregarlas al `PATH`.

Después de eso, instala los componentes necesarios con:

```bash
sdkmanager --install \
  "platform-tools" \
  "platforms;android-35" \
  "build-tools;35.0.0"
```

Acepta las licencias de google:

```bash
flutter doctor --android-licenses
```

Verifica que Flutter detecte correctamente el entorno:

```bash
flutter doctor
```
Aquí el apartado Android debería aparecer con un [✓]

#### Compilar APK

```bash
flutter build apk
```

El archivo generado estará en:

```bash
build/app/outputs/flutter-apk/app-release.apk
```