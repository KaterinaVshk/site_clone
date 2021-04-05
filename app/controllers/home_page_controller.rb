class HomePageController < ApplicationController
  skip_before_action :authentication, only: [:index]
  def index; end
end
