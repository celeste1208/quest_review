class Comment < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :quest
  
  has_many :children, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment", optional: true
  
  validates :content, presence: true
  validates :opinion_type, presence: true
  
  def is_parent
    self.parent_id.blank?
  end
end
