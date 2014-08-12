class User < ActiveRecord::Base
  include ApplicationHelper

  has_many :user_tags, primary_key: :account_id, foreign_key: :user_id

  def self.get_by_nickname nickname
    users = User.where(nickname:nickname)
    if users.empty?
      load_by_nickname nickname
      users = User.where(nickname:nickname)
    end
    users
  end

  def self.load_by_nickname nickname
    data = load_users nickname
    if data && data.include?('items') && !data['items'].size.zero?
      items = data['items']
      items.each do |item|
        if item['display_name'] == nickname
          User.create account_id: item['account_id'], nickname: item['display_name'], profile_image: item['profile_image'], link: item['link']
        end
      end
    end
  end

  def tag_list
    tag_ids = user_tags.map{|user_tag| user_tag.tag_id}
    Tag.where(id:tag_ids).map{|tag| tag.title}.join(', ')
  end

  def get_actual_tags
    tags = user_tags
    if tags.empty?
      data = User.load_tags account_id
      if data && data.include?('items') && !data['items'].size.zero?
        items = data['items'].map{|tag| tag['name']}
        existing_tags = Tag.where(title:items)
        nonexisting_tags = items - existing_tags
        nonexisting_tags.each do |tag_name|
          tag = Tag.where(title:tag_name).load
          tag = tag.size.zero? ? Tag.create(title:tag_name) : tag[0]
          UserTag.create(tag: tag, user: self)
        end
      end
      User.find(account_id).user_tags
    else
      tags
    end
  end
end
