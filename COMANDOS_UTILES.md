# Guía Maestra de Comandos y Estándares - Ruby on Rails

Esta guía detalla los comandos esenciales y las mejores prácticas para el desarrollo de aplicaciones robustas en Rails.

## 1. Configuración del Entorno
Siempre use `bin/` para asegurar que está utilizando la versión de los ejecutables instalada en su proyecto.

```bash
# Instalar dependencias definidas en el Gemfile
bundle install

# Actualizar gemas específicas respetando versiones
bundle update <gem_name>
```

## 2. Generación de Modelos y Relaciones
Para seguir los estándares de Rails, utilice generadores para crear modelos con tipos de datos correctos e índices de base de datos.

### Ejemplo: Sistema de Enciclopedia con Comentarios
```bash
# 1. Modelo Principal
bin/rails generate model Article title:string content:text author:string date:date

# 2. Modelo Relacionado (Uno a Muchos)
bin/rails generate model Comment body:text article:references
```

## 3. Gestión y Debugging de Base de Datos
Siga el ciclo de vida de las migraciones y use estas herramientas para diagnosticar problemas.

```bash
# Ejecutar migraciones
bin/rails db:migrate

# VER EL ESTADO: ¿Qué migraciones faltan o fallaron?
bin/rails db:migrate:status

# VER EL ESQUEMA: Inspeccionar la estructura actual de tablas
cat db/schema.rb

# LIMPIEZA TOTAL: Resetear la DB de pruebas si hay datos residuales
bin/rails db:test:prepare
```

## 4. Creación de Endpoints (Flujo del Reto)
Para crear una nueva funcionalidad, siga siempre este orden lógico:

### Paso 1: Definir la Ruta (`config/routes.rb`)
```ruby
# Crea rutas estándar para el CRUD
resources :articles
# Establece la página principal
root "articles#index"
```

### Paso 2: Crear el Controlador y la Acción (`app/controllers/articles_controller.rb`)
```ruby
def index
  @articles = Article.all
end
```

### Paso 3: Implementar la Lógica en el Modelo (`app/models/article.rb`)
```ruby
def self.search(query)
  where("title LIKE ?", "%#{query}%")
end
```

### Paso 4: Crear la Vista (`app/views/articles/index.html.erb`)
```erb
<% @articles.each do |article| %>
  <%= link_to article.title, article %>
<% end %>
```

## 5. Pruebas y Calidad (Estándar Shopify/Rails)
La calidad se garantiza con pruebas automatizadas y análisis estático.

```bash
# Ejecutar todas las pruebas
bin/rails test

# Ejecutar una prueba específica (Modelo o Controlador)
bin/rails test test/models/article_test.rb
bin/rails test test/controllers/articles_controller_test.rb
```

## 6. Consola y Debugging de Datos
Herramientas para interactuar con los datos en tiempo real.

```bash
# Abrir consola de Rails
bin/rails console

# Ejemplos de Debugging en consola:
Article.count                     # ¿Hay datos?
Article.last                      # Ver el último registro creado
Article.search("Query").to_sql    # Ver la consulta SQL generada
```

## 7. Mantenimiento y Logs
```bash
# Limpiar archivos temporales y logs antiguos
bin/rails tmp:clear log:clear

# Ver logs en tiempo real para detectar errores 500
tail -f log/development.log
```

## Estándares de Código a Recordar:
1. **DRY (Don't Repeat Yourself):** Use `before_action` en controladores y `partials` en vistas.
2. **Fat Models, Skinny Controllers:** La lógica de negocio (como la búsqueda) vive en el modelo.
3. **Strong Parameters:** Use `.require(:model).permit(:attr)` para seguridad.
4. **Naming:** Modelos en Singular (`Article`), Controladores en Plural (`ArticlesController`).
