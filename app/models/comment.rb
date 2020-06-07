class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :quest
  
  validates :content, presence: true
  validates :opinion_type, presence: true
end
