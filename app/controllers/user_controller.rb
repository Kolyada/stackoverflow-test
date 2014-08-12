class UserController < ApplicationController
  def index
    @nickname = params.permit(:nickname)[:nickname]
    @users = @nickname.nil? ? nil : User.get_by_nickname(@nickname)
  end

  def show
    @account_id = params.permit(:id)[:id]
    users = User.where(account_id: @account_id)
    (redirect_to(root_path) && return) if users.empty?
    @user = users[0]
    @tag_list = @user.tag_list
    user_tags = @user.get_actual_tags
    user_tags.each{|user_tag| user_tag.tag.update_questions if user_tag.tag.need_update_questions?}
    tag_ids = user_tags.map{|user_tag| user_tag.tag_id}
    @questions = Question.includes(:tag).where(tag_id:tag_ids)
  end
end
