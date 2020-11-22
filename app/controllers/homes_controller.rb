class HomesController < ApplicationController
  def index; end

  def show
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def check
    @users = User.all
  end
end
