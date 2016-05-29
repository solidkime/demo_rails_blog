class Station < ActiveRecord::Base


  validates :number, numericality: { :less_than_or_equal_to 5,
    message: "Число %{count} слишком большое"}


  validates :title, presence: true
  validates :text, presence: true
  validates :title, length: {maximum: 140}
  validates :text, length: {maximum: 4000}

  has_many :comments
  belongs_to :user



end
