class PreferencesService
  def initialize(comment_id:, user_id:, type:)
    @comment_id = comment_id
    @user_id = user_id
    @type = type
  end

  def perform
    @preference = Preference.find_or_initialize_by(comment_id: @comment_id, user_id: @user_id)
    if preference.persisted?
      change_preference
    else
      save_preference
    end
    response
  end

  private

  attr_reader :preference, :response

  def change_preference
    if preference.type == @type
      preference.destroy!
      @response = 'Реакция удалена'
    else
      preference.update!(type: @type)
      @response = 'Реакция обновлена успешно'
    end
    Comment.reset_counters(@comment_id, :likes)
    Comment.reset_counters(@comment_id, :dislikes)
  end

  def save_preference
    @response =
      if preference.update!(type: @type)
        'Реакция сохранена'
      else
        'Не удалось сохранить реакцию'
      end
    Comment.reset_counters(@comment_id, :"#{@type.downcase}s")
  end
end
