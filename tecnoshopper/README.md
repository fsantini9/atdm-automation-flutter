# TecnoShopper - Carrito de Compras

Aplicación Flutter de e-commerce para productos electrónicos y tecnología.

## Características

- **Catálogo de Productos**: Más de 30 productos tecnológicos (laptops, consolas, accesorios, componentes PC, periféricos)
- **Carrito de Compras**: Agregar, eliminar y gestionar productos con gestión de estado vía Provider
- **Autenticación de Usuarios**: Registro e inicio de sesión con almacenamiento local en JSON
- **Multiplataforma**: Soporte para Android, iOS, Web, Windows, macOS y Linux
- **Pruebas de Integración**: Testing automatizado con Patrol

## Requisitos

- Flutter SDK >= 3.2.0
- Dart SDK >= 3.2.0

## Estructura del Proyecto

```
lib/
├── components/          # Componentes reutilizables (UI)
├── form_inputs/         # Campos de formulario personalizados
├── pages/
│   ├── carrito_forms/   # Páginas del carrito de compras
│   ├── compra_forms/    # Proceso de checkout y compra
│   ├── home_forms/      # Página principal y demo
│   ├── login_forms/     # Autenticación de usuarios
│   └── helpers/         # Utilidades y opciones
├── styles/              # Temas, colores y estilos globales
└── main.dart            # Punto de entrada de la aplicación

assets/
└── productos.json       # Catálogo de productos
```

## Dependencias Utilizadas

| Paquete                                | Propósito                           |
| -------------------------------------- | ----------------------------------- |
| `provider`                             | Gestión de estado del carrito       |
| `flutter_masked_text2`                 | Máscaras de entrada de texto        |
| `path_provider` / `shared_preferences` | Almacenamiento local                |
| `patrol`                               | Testing de integración              |
| `csv`                                  | Manejo de archivos CSV              |
| `flutter_svg`                          | Renderizado de SVGs                 |
| `font_awesome_flutter`                 | Iconos Font Awesome                 |

## Instalación y Ejecución

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo desarrollo
flutter run

# Ejecutar en modo release
flutter run --release

# Ejecutar tests unitarios
flutter test

# Ejecutar tests de integración con Patrol
patrol test
```

## Allure Reports

El proyecto está configurado con **Allure Report** para generar reportes visuales de los tests de integración.

### 1. Instalar Allure CLI

**macOS:**

```bash
brew install allure
```

**Windows:**

```bash
scoop install allure
```

**Linux:**

```bash
sudo apt-add-repository ppa:qameta/allure
sudo apt-get update
sudo apt-get install allure
```

O descargar manualmente desde: https://github.com/allure-framework/allure2/releases

### 2. Ejecutar Tests con Allure (Android)

Los tests de Patrol en Android ya están configurados para generar resultados de Allure:

```bash
# Ejecutar tests de integración
patrol test --target integration_test/app_test.dart

# O ejecutar directamente con gradle
./gradlew :app:connectedDebugAndroidTest
```

### 3. Extraer Resultados del Dispositivo

Los archivos de Allure se generan en el dispositivo/emulador. Extraerlos:

```bash
# Crear directorio para resultados
mkdir -p allure-results

# Extraer desde el dispositivo (Android)
adb pull /sdcard/allure-results/ ./allure-results/

# Alternativa: extraer desde almacenamiento interno de pruebas
adb shell run-as com.example.flutter_ces cat /data/data/com.example.flutter_ces/files/allure-results/ > ./allure-results/
```

### 4. Generar y Ver Reporte

```bash
# Generar reporte HTML
allure generate ./allure-results --clean

# Servir reporte en servidor local (http://localhost:8080)
allure serve ./allure-results

# Abrir reporte existente
allure open ./allure-report
```

### Estructura de Reportes

```
allure-results/          # Datos brutos de ejecución
├── *.json               # Resultados de tests
├── *.txt                # Attachments (logs, screenshots)
└── environment.properties # Variables de entorno

allure-report/           # Reporte HTML generado
├── index.html           # Página principal
└── data/                # Datos del reporte
```

### Configuración Android

La configuración actual utiliza `AllurePatrolJUnitRunner` en:

- **Archivo:** `android/app/src/androidTest/java/com/example/flutter_ces/AllurePatrolJUnitRunner.kt`
- **Runner configurado en:** `android/app/build.gradle`

### Capturas de Pantalla Automáticas

Allure captura automáticamente:

- Screenshots en fallos
- Logs de aplicación
- Pasos de ejecución
- Tiempos de respuesta

## Build para Producción

```bash
# Android APK
flutter build apk --release

# Android App Bundle (para Google Play)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

## Datos de Prueba

El catálogo de productos se carga desde `assets/productos.json` con más de 30 items.

## Licencia

Proyecto privado - TecnoShopper
