class Quest < ApplicationRecord
  acts_as_paranoid
  validates :develop_id, presence: true, uniqueness: true
  validates :responsible, presence: true
  validates :title, presence: true
end
