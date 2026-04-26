# Rails Master Command & Standards Cheat Sheet

## 1. Environment Setup
Always use `bin/` to ensure you're using the project's installed executables.

```bash
# Install dependencies from Gemfile
bundle install

# Update specific gems respecting versions
bundle update <gem_name>

# Set up database (creates, loads schema, seeds)
bin/rails db:setup

# Check Ruby version & dependencies
ruby -v
bundle outdated
```

## 2. Model & Relationship Generation
Follow Rails standards: use generators with correct data types and database indexes.

### Example: Encyclopedia System with Comments
```bash
# 1. Main Model
bin/rails generate model Article title:string content:text author:string date:date

# 2. Related Model (One to Many)
bin/rails generate model Comment body:text article:references
```

### Additional Generators
```bash
# Join model for many-to-many
bin/rails generate model Tag name:string
bin/rails generate model ArticleTag article:references tag:references

# Add column to existing model
bin/rails generate migration AddStatusToArticles status:integer
```

## 3. Database Management & Debugging
Follow the migration lifecycle and use these tools to diagnose issues.

```bash
# Run migrations
bin/rails db:migrate

# CHECK STATUS: What migrations are missing or failed?
bin/rails db:migrate:status

# CHECK SCHEMA: Inspect current table structure
cat db/schema.rb

# ROLLBACK: Undo last migration
bin/rails db:rollback

# FULL CLEAN: Reset test DB if residual data exists
bin/rails db:test:prepare

# Reset dev DB (drop, create, migrate, seed)
bin/rails db:reset

# Seed database with initial data
bin/rails db:seed

# View database queries in real time (dev log)
tail -f log/development.log
```

## 4. Creating Endpoints (Challenge Flow)
To add new functionality, always follow this logical order:

### Step 1: Define Route (`config/routes.rb`)
```ruby
# Creates standard CRUD routes
resources :articles

# Nested resources
resources :articles do
  resources :comments
end

# Custom collection/member routes
resources :articles do
  collection { get :search }
  member { post :publish }
end

# Set root/home page
root "articles#index"
```

### Step 2: Create Controller & Action (`app/controllers/articles_controller.rb`)
```ruby
def index
  @articles = Article.all
end

def show
  @article = Article.find(params[:id])
end

def create
  @article = Article.new(article_params)
  if @article.save
    redirect_to @article, notice: "Article created!"
  else
    render :new, status: :unprocessable_entity
  end
end

private

def article_params
  params.require(:article).permit(:title, :content, :author, :date)
end
```

### Step 3: Implement Business Logic in Model (`app/models/article.rb`)
```ruby
def self.search(query)
  where("title LIKE ?", "%#{query}%")
end

# Callbacks
after_create :send_notification

# Validations
validates :title, presence: true, length: { minimum: 5 }

# Scopes
scope :published, -> { where(published: true) }
```

### Step 4: Create View (`app/views/articles/index.html.erb`)
```erb
<% @articles.each do |article| %>
  <%= link_to article.title, article %>
<% end %>
```

### Step 5: Partials for reusability
```erb
# app/views/shared/_form.html.erb
<%= form_with model: local_assigns[:article] do |form| %>
  <%= form.text_field :title %>
<% end %>

# Render with: <%= render "shared/form", article: @article %>
```

## 5. Debugging & Console Tools

### Rails Console
```bash
# Open Rails console
bin/rails console
# or
bin/rails c

# Sandbox mode (no changes persisted)
bin/rails c --sandbox
```

### Console Debugging Examples
```ruby
Article.count                     # How many records?
Article.last                      # View last created record
Article.search("Query").to_sql    # View generated SQL query
Article.find_by(title: "Rails")   # Find by attribute

# Debugging with breakpoints
require 'pry'; binding.pry         # Stop execution (add in code)
debugger                           # Rails 7+ native debugger

# Reload code without restarting console
reload!

# View loaded routes
Rails.application.routes.url_helpers
```

### Logging & Error Tracking
```ruby
# In controllers/models
Rails.logger.debug "Debug message"
Rails.logger.info "Info message"
Rails.logger.error "Error: #{e.message}"

# Better debugging in views
<%= debug @article %>
<%= params.inspect %>
```

## 6. Testing & Quality Assurance (Shopify/Rails Standard)
Quality is guaranteed with automated tests and static analysis.

```bash
# Run all tests
bin/rails test

# Run specific test (Model or Controller)
bin/rails test test/models/article_test.rb
bin/rails test test/controllers/articles_controller_test.rb

# Run single test by line number
bin/rails test test/models/article_test.rb:15

# System tests
bin/rails test:system

# Run tests with verbose output
bin/rails test -v
```

### Testing Examples
```ruby
# test/models/article_test.rb
test "should search articles" do
  article = Article.create(title: "Rails Guide", content: "test")
  assert_includes Article.search("Rails"), article
end
```

### Code Quality Tools
```bash
# Linter (add to Gemfile: rubocop)
rubocop
rubocop -a # Auto-correct

# Security checks
bundler-audit check
brakeman

# Performance profiling
rack-mini-profiler
```

## 7. Assets & Frontend (Propshaft/Sprockets)
```bash
# Precompile assets for production
bin/rails assets:precompile

# Clean old assets
bin/rails assets:clobber

# JS/CSS with importmaps or webpack
bin/rails importmap:install
bin/rails stimulus:install
bin/rails tailwindcss:install
```

## 8. Background Jobs (Active Job)
```bash
# Generate a job
bin/rails generate job notify_user

# Run job
NotifyUserJob.perform_later(@user)

# Run job synchronously (for testing)
NotifyUserJob.perform_now(@user)

# Start job adapter (for Sidekiq/Resque)
bundle exec sidekiq
```

### Job Example
```ruby
# app/jobs/notify_user_job.rb
class NotifyUserJob < ApplicationJob
  queue_as :default
  def perform(user)
    UserMailer.welcome_email(user).deliver_now
  end
end
```

## 9. Action Mailer Configuration
```bash
# Generate mailer
bin/rails generate mailer UserMailer welcome_email

# Preview mailers in browser
# Visit: http://localhost:3000/rails/mailers

# Create preview file
# test/mailers/previews/user_mailer_preview.rb
```

## 10. Credentials & Secrets Management
```bash
# Edit credentials (encrypted)
EDITOR="code --wait" bin/rails credentials:edit

# View credentials
bin/rails credentials:show

# Use different environment
bin/rails credentials:edit --environment production

# Access in code
Rails.application.credentials.stripe[:api_key]
```

## 11. Maintenance & Housekeeping
```bash
# Clean temporary files and old logs
bin/rails tmp:clear log:clear

# Clear cache
bin/rails cache:clear

# Restart app (in production)
touch tmp/restart.txt

# View live logs for error detection (500 errors)
tail -f log/development.log
tail -f log/production.log

# Check routes
bin/rails routes
bin/rails routes | grep article

# Check middleware stack
bin/rails middleware
```

## 12. Plugins & Engines
```bash
# Create a Rails plugin
bin/rails plugin new my_plugin

# Mount engine in routes
mount MyPlugin::Engine, at: "/my_plugin"

# List all installed plugins
bin/rails runner "Rails::Engine.subclasses.map(&:to_s)"
```

## 13. Generators Cheatsheet (Common Use Cases)
```bash
bin/rails generate controller Home index
bin/rails generate scaffold Product name price:decimal
bin/rails generate migration AddIndexToUsers email
bin/rails generate system_test users
bin/rails generate channel chat
```

## Coding Standards to Remember:

1. **DRY (Don't Repeat Yourself):** Use `before_action` in controllers and `partials` in views.

2. **Fat Models, Skinny Controllers:** Business logic (like search) lives in the model.

3. **Strong Parameters:** Use `.require(:model).permit(:attr)` for security.

4. **Naming:** Models Singular (`Article`), Controllers Plural (`ArticlesController`).

5. **Convention Over Configuration:** Follow Rails defaults unless you have a good reason.

6. **7 Restful Actions:** index, show, new, create, edit, update, destroy.

7. **Use Concerns for shared code:** `app/models/concerns/searchable.rb`

8. **Environment-specific config:** `config/environments/development.rb`, `production.rb`, `test.rb`

9. **I18n for translations:** Use `t('article.title')` instead of hardcoding.

10. **Always add indexes for foreign keys:** `add_index :comments, :article_id`

---

**Quick Reference: Most Used Commands**
```bash
bin/rails s      # Start server
bin/rails c      # Open console
bin/rails routes # List all routes
bin/rails test   # Run tests
bin/rails db:migrate
bin/rails db:rollback
bin/rails --help # Show all commands
```
