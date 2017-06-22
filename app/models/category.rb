class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates :name, presence: true, uniqueness: true, length: { in: 3..25 }
    
end