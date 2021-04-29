class Article < ApplicationRecord
  CATEGORY_MAP = { people: 1, opinions: 2, auto: 3, technologies: 4, realt: 5 }.freeze
  RUSSION_CATEGORY_MAP = { 1 => 'Люди', 2 => 'Мнения', 3 => 'Авто', 4 => 'Технологии', 5 => 'Недвижимость' }.freeze
  has_one_attached :image
  validates :title, presence: { message: 'Укажите название' }
  validates :image, presence: { message: 'Прикрепите фото/картинку' }
  validates :text, presence:  { message: 'Напишите текст' }
  belongs_to :category
  belongs_to :admin
  has_many :comments, as: :commentable, dependent: :delete_all
  MONTH_MAP = {
    1 => 'января',
    2 => 'февраля',
    3 => 'марта',
    4 => 'апреля',
    5 => 'мая',
    6 => 'июня',
    7 => 'июля',
    8 => 'августа',
    9 => 'сентября',
    10 => 'октября',
    11 => 'декабря',
    12 => 'декабря'
  }.freeze

  def parse_date
    date = created_at
    now = Time.zone.now.strftime('%d-%m')
    if date.strftime('%d-%m') == now
      "Сегодня в #{date.strftime('%H:%M')}"
    else
      "#{date.day} #{Article::MONTH_MAP[date.month]} #{Article::MONTH_MAP[date.year]} в #{date.strftime('%H:%M')}"
    end
  end

  def category_russian_name
    Article::RUSSION_CATEGORY_MAP[category_id]
  end
end
