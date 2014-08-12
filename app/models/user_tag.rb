class UserTag < ActiveRecord::Base
  belongs_to :user, primary_key: :account_id, foreign_key: :user_id
  belongs_to :tag, primary_key: :id, foreign_key: :tag_id
end
