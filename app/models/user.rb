class User < ApplicationRecord
  acts_as_paranoid
  has_many :comment, dependent: :destroy
  
  validates :user_name, presence: true, uniqueness: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  mount_uploader :image, UserImageUploader
end
