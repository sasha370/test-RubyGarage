class Task < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 100}

  belongs_to :project

  # Подключаем ранжирование внутри Задач
  include RankedModel
  # Сортируем внутри курса
  ranks :row_order, :with_same => :project_id



end
