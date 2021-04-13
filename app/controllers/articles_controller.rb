class ArticlesController < ApplicationController
  skip_before_action :authentication
  before_action :set_tour, only: %i[show edit update destroy]
  CATEGORY_MAP = { people: 1, opinions: 2, auto: 3, technologies: 4, realt: 5 }.freeze
  def index
    @articles = find_articles
  end

  def new; end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to(action: 'show', id: @article)
    else
      render('new')
    end
  end

  def show; end

  def edit; end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to(action: 'show', id: @article)
    else
      redirect_to(action: 'edit', id: @article)
    end
  end

  def destroy
    @article.destroy!
    redirect_to(root_path)
  end

  private

  def set_tour
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :image, :category_id)
  end

  def find_articles
    if params[:category] == 'all'
      Article.all
    else
      Article.find_by(category_id: CATEGORY_MAP[params[:category].to_sym])
    end
  end
end
