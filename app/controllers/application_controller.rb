class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_logged_in?
  before_action :authentication
  helper_method :admin?
  helper_method :check_admin
  before_action :load_articles

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    !current_user.nil?
  end

  def authentication
    redirect_to('/login') unless current_user
  end

  def admin?
    current_user.is_a?(Admin)
  end

  def check_admin
    redirect_to(root_path) unless admin?
  end

  def load_articles
    all_articles = Article.all.order(created_at: :desc).to_a
    @articles_navbar = []
    Article::CATEGORY_MAP.each_pair do |_key, value|
      @articles_navbar << all_articles.select { |article| article.category_id == value }[0..2]
    end
    @articles_navbar
  end
end
