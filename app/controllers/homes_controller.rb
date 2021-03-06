class HomesController < ApplicationController
  def index; end

  def show
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def check
    @users = User.all
  end
end
