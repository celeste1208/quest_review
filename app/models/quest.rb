class Quest < ApplicationRecord
  acts_as_paranoid
  has_many :comment
  validates :develop_id, presence: true, uniqueness: true
  validates :responsible, presence: true
  validates :title, presence: true
end
