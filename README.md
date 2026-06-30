# THREED - Calculadora de Impresión 3D

THREED es una aplicación móvil desarrollada en Flutter diseñada para calcular de forma precisa y rápida los costos de impresiones 3D. Integra consumo de APIs REST para obtener propiedades físicas de filamentos en tiempo real y utiliza la nube para mantener un historial seguro de cotizaciones.
## Características Principales

    - Cálculo Avanzado de Costos: Calcula el precio final de venta basado en el consumo de material (gramos), tiempo de máquina (horas) y parámetros configurables.

    - Catálogo de Filamentos en la Nube: Integración directa con la API de la Open Filament Database. Permite explorar marcas (ej. eSUN), materiales (PLA, PETG, ABS) y obtener datos técnicos precisos como densidades y temperaturas óptimas de extrusión y cama.

    - Historial Seguro: Las cotizaciones se guardan automáticamente en la nube.

    - Autenticación Anónima: Acceso a la base de datos mediante Firebase Authentication sin fricción para el usuario, manteniendo los historiales aislados y seguros por cada dispositivo mediante reglas de seguridad de Firestore.

    - Modo Oscuro Integrado: Interfaz de usuario adaptable con alto contraste y diseño ergonómico.

## Tecnologías y Arquitectura

El proyecto está construido siguiendo buenas prácticas de separación de responsabilidades y Clean Architecture:

    - Framework: Flutter (Dart).

    - Gestor de Estado: Provider (para el manejo reactivo de la UI y consumo asíncrono de la API).

    - Base de Datos: Firebase Cloud Firestore.

    - Autenticación: Firebase Auth (Anonymous Sign-In).

    - Peticiones de Red: Paquete http para consumo de API REST.

## Estructura de Carpetas Destacada
Plaintext

lib/
├── models/         # Traductores JSON a Dart (FilamentDetail, SpecificFilament)
├── providers/      # Lógica de negocio y estado (FilamentProvider)
├── repositories/   # Conexión a datos externos (FilamentRepository, HistoryRepository)
├── screens/        # Interfaz de usuario (CalculateScreen, FilamentsScreen, etc.)
└── services/       # Servicios internos (CalculatorService)

## Instalación y Uso

    Clona este repositorio:
    Bash

    git clone https://github.com/tu-usuario/threed-calculator.git

    Instala las dependencias:
    Bash

    flutter pub get

    Configura Firebase:

        Asegúrate de tener tu archivo google-services.json (Android) configurado en android/app/.

        Verifica que las reglas de Firestore estén configuradas para permitir lectura/escritura solo a usuarios autenticados con su respectivo UID.

    Compila y ejecuta la aplicación:
    Bash

    flutter run

    (Para compilar el APK de producción, utiliza flutter build apk --release).

## Pantallas Principales

    Start Screen: Menú principal tipo cuadrícula para acceso rápido a las funciones.

    Calculate Screen: Formulario de cálculo de costos con retroalimentación visual jerárquica.

    Config Screen: Ajuste de parámetros base para el cálculo.

    Filaments Screen (Flow): Navegación anidada que consulta la API externa: Materiales -> Variantes -> Detalles Técnicos.

    History Screen: Lista dinámica extraída desde Firestore con los presupuestos guardados.