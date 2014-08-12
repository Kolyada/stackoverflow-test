class Question < ActiveRecord::Base
  belongs_to :tag, primary_key: :id, foreign_key: :tag_id
  validates :id, uniqueness: true
end
