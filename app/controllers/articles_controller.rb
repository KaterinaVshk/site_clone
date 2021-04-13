class ArticlesController < ApplicationController
  skip_before_action :authentication
  before_action :set_article, only: %i[show edit update destroy]
  def index
    @articles = find_articles
  end

  def new; end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to(action: 'show', id: @article)
    else
      redirect_to(action: 'new', notice: 'Данные заполнены неверно, попробуйте ещё раз')
    end
  end

  def show; end

  def edit; end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to(action: 'show', id: @article)
    else
      redirect_to(action: 'edit', id: @article, notice: 'Данные заполнены неверно, попробуйте ещё раз')
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
    params.require(:article).permit(:title, :text, :image, :category_id)
  end

  def find_articles
    if Article::CATEGORY_MAP.include?(params[:category].to_sym)
      Article.find_by(category_id: Article::CATEGORY_MAP[params[:category].to_sym])
    else
      Article.all
    end
  end
end
