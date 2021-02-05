class HomesController < ApplicationController
  def index
    @users = User.all
    @man_count = 0
    @woman_count = 0
    @other_count = 0
    @no_answer_count = 0
    @users.each do |user|
      case user.sex
      when 'man'
        @man_count += 1
      when 'woman'
        @woman_count += 1
      when 'other'
        @other_count += 1
      when 'no_answer'
        @no_answer_count += 1
      else
        @no_answer_count += 1
      end
    end
  end

  def show
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def check
    @users = User.all
  end
end
