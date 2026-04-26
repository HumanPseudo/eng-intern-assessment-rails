# Pasos para cumplir el reto técnico - Encyclopedia Rails

Este documento detalla los pasos necesarios para implementar la funcionalidad requerida y hacer que todas las pruebas pasen.

## 1. Configuración Inicial
- [x] Clonar el repositorio.
- [x] Ejecutar `bundle install` para instalar las dependencias.
- [x] Crear una nueva rama de Git para trabajar: `git checkout -b implementacion-enciclopedia`.

## 2. Creación del Modelo Article
El modelo debe tener los campos identificados en las pruebas (`test/models/article_test.rb`):
- `title`: string
- `content`: text
- `author`: string
- `date`: date

- [x] Generar el modelo: `bin/rails generate model Article title:string content:text author:string date:date`.
- [x] Ejecutar las migraciones: `bin/rails db:migrate`.

## 3. Implementación de la Búsqueda
La prueba `has search functionality` y `returns accurate search results` requieren un método de clase en el modelo.
- [x] Abrir `app/models/article.rb`.
- [x] Implementar el método `self.search(query)` que busque en el título o contenido.

## 4. Desarrollo del Controlador (CRUD)
Implementar las acciones estándar de Rails para cumplir con los principios MVC.
- [x] Generar el controlador: `bin/rails generate controller Articles`.
- [x] Implementar las acciones:
    - `index`: Listar todos los artículos (y manejar la búsqueda).
    - `show`: Mostrar un artículo específico.
    - `new` / `create`: Formulario y lógica para crear artículos.
    - `edit` / `update`: Formulario y lógica para editar artículos.
    - `destroy`: Lógica para eliminar artículos.

## 5. Configuración de Rutas
- [x] Definir las rutas en `config/routes.rb` usando `resources :articles`.
- [x] (Opcional) Establecer la página de inicio en `articles#index`.

## 6. Creación de Vistas
Crear interfaces simples para interactuar con la aplicación.
- [x] `index.html.erb`: Lista de artículos y formulario de búsqueda.
- [x] `show.html.erb`: Detalle del artículo (título, contenido, autor, fecha).
- [x] `new.html.erb` y `edit.html.erb`: Formularios para el modelo.


## 7. Validación y Pruebas
- [x] Ejecutar las pruebas: `bin/rails test`.
- [x] Asegurarse de que todas las pruebas en `test/models/article_test.rb` pasen.
- [x] Verificar manualmente en el navegador que el CRUD funcione correctamente.

## 8. Finalización
- [x] Documentar el código con comentarios útiles.
- [x] Realizar commits de tus cambios.
- [x] Crear el Pull Request hacia la rama principal.
