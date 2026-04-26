# Comandos Útiles - Encyclopedia Rails

Este archivo contiene los comandos de terminal necesarios para el desarrollo, pruebas y despliegue del proyecto.

## 1. Configuración y Dependencias
Instalar gemas del proyecto:
```bash
bundle install
```

## 2. Generación de Código (Scaffolding/Modelos)
Crear el modelo Article con sus atributos:
```bash
bin/rails generate model Article title:string content:text author:string date:date
```

Generar el controlador para Articles:
```bash
bin/rails generate controller Articles
```

## 3. Base de Datos
Ejecutar migraciones pendientes:
```bash
bin/rails db:migrate
```

Resetear la base de datos (si es necesario):
```bash
bin/rails db:migrate:reset
```

## 4. Pruebas (Minitest)
Preparar la base de datos de pruebas (limpiar datos):
```bash
bin/rails db:test:prepare
```

Ejecutar todas las pruebas del proyecto:
```bash
bin/rails test
```

Ejecutar solo las pruebas del modelo Article:
```bash
bin/rails test test/models/article_test.rb
```

> **Nota sobre Fixtures:** Si las pruebas fallan indicando que existen registros inesperados, revisa o vacía el archivo `test/fixtures/articles.yml`.

## 5. Calidad de Código (Linting)
Para mantener el código limpio, se recomienda usar RuboCop (si está en el Gemfile):
```bash
# Analizar el código
bundle exec rubocop

# Corregir automáticamente errores de estilo
bundle exec rubocop -A
```

## 6. Servidor de Desarrollo
Iniciar el servidor local (usualmente en http://localhost:3000):
```bash
bin/rails server
```

## 7. Consola de Rails
Entrar a la consola interactiva para manipular datos:
```bash
bin/rails console
```

## 8. Limpieza de Temporales
Limpiar logs y archivos temporales de Rails:
```bash
bin/rails log:clear tmp:clear
```
