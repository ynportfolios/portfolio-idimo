class HomesController < ApplicationController
  def index
    @users = User.all
    @man_count = 0
    @woman_count = 0
    @other_count = 0
    @no_answer_count = 0
    @users.each do |user|
      case user.sex
      when 'man' then
        @man_count += 1
      when 'woman' then
        @woman_count += 1
      when 'other' then
        @other_count += 1
      when 'no_answer' then
        @no_answer_count += 1
      else
        @no_answer_count += 1
      end
    end
  end

  def show
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def check
    @users = User.all
  end
end
