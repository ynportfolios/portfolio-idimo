class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update destroy]
  before_action :destroy_room, only: %i[destroy]
end
