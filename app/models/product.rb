class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reviews

  validates :title, :description, :price, presence: true
  validates :price,
            :numericality => true,
            :format => { :with => /\A\d{1,4}(\.\d{0,2})?\z/ }

  def average_rating
    self.reviews.average(:rating)
  end
end
