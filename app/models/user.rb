class User < ActiveRecord::Base
  validates :username, 
            presence: true, 
            length: { in:3..25 }, 
            uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 100 },
            format: { with: VALID_EMAIL_REGEX }
end