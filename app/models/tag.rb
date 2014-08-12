class Tag < ActiveRecord::Base
  include ApplicationHelper
  has_many :user_tags, primary_key: :id, foreign_key: :tag_id
  has_many :questions, primary_key: :id, foreign_key: :tag_id
  validates :title, uniqueness: true

  def need_update_questions?
    questions_last_update.nil? || (Time.now - questions_last_update > 60*60*24)
  end

  def update_questions
    data = Tag.load_questions title
    if data && data.include?('items') && !data['items'].size.zero?
      items = data['items']
      Question.where(tag_id: id).delete_all
      items.each do |item|
        Question.create id:item['question_id'], title:item['title'], link:item['link'], tag:self
      end
      self.questions_last_update=Time.now
      self.save
    end
  end

end
