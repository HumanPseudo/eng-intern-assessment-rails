# Handles the CRUD logic for Articles and provides search functionality.
class ArticlesController < ApplicationController
  # Sets the @article variable for specific actions to maintain DRY principles.
  before_action :set_article, only: %i[show edit update destroy]

  # Displays a list of all articles, filtered by a search query if provided.
  # GET /articles
  def index
    @articles = Article.search(params[:query])
  end

  # Displays a single article.
  # GET /articles/:id
  def show
  end

  # Initializes a new article for the creation form.
  # GET /articles/new
  def new
    @article = Article.new
  end

  # Processes the creation of a new article.
  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Displays the form to edit an existing article.
  # GET /articles/:id/edit
  def edit
  end

  # Processes the update of an existing article.
  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Removes an article from the database.
  # DELETE /articles/:id
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Finds an article by ID from the database.
  def set_article
    @article = Article.find(params[:id])
  end

  # Sanitizes input parameters for Article creation and updates.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
