class ArticlesController < ApplicationController
  skip_before_action :authentication, only: %i[index show]
  before_action :check_admin, only: %i[new create edit update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  def index
    @articles = find_articles
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to(action: 'show', id: @article)
    else
      flash[:alert] = 'Данные заполнены неверно, попробуйте ещё раз'
      render('new')
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to(action: 'show', id: @article)
    else
      flash[:alert] = 'Данные заполнены неверно, попробуйте ещё раз'
      redirect_to(action: 'edit')
    end
  end

  def destroy
    @article.destroy!
    redirect_to(root_path)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    parameters = params.require(:article).permit(:title, :text, :image)
    parameters[:category_id] = Article::CATEGORY_MAP[params[:article][:category].to_sym]
    parameters
  end

  def find_articles
    if Article::CATEGORY_MAP.include?(params[:category].to_sym)
      Article.where(category_id: Article::CATEGORY_MAP[params[:category].to_sym])
    else
      Article.all
    end
  end
end
