class PreferencesController < ApplicationController
  def create
    response = PreferencesService.new(comment_id: params[:comment_id], user_id: params[:user_id], type: params[:type]).perform
    if response == 'Не удалось сохранить реакцию'
      flash[:alert] == response
    else
      flash[:notice] == response
    end
    redirect_to(article_path(params[:article_id]))
  end
end
