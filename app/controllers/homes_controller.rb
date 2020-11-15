class HomesController < ApplicationController
  def index; end

  def show
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
