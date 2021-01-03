require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:user) { create(:user) }
  let(:user_a) { create(:user_a) }

  describe 'ログインしてルームのフォローを行う' do
    before do
      user.confirm
      sign_in user
    end
    it 'フォローに成功する' do
      post relationships_path(follow_id: user_a.id)
      expect(response).to redirect_to users_show_path(id: user_a.id)
      expect(flash[:success]).to include 'フォローしました。'
    end
    it 'フォローに失敗する' do
      Relationship.any_instance.stub(:save).and_return(false)
      post relationships_path(follow_id: user_a.id)
      expect(response).to redirect_to users_show_path(id: user_a.id)
      expect(flash.now[:alert]).to include 'フォローに失敗しました。'
    end
    it 'フォロー解除に成功する' do
      post relationships_path(follow_id: user_a.id)
      expect(response).to redirect_to users_show_path(id: user_a.id)
      expect(flash[:success]).to include 'フォローしました。'
      delete relationship_path(user_a.id, follow_id: user_a.id)
      expect(response).to redirect_to users_show_path(id: user_a.id)
      expect(flash[:success]).to include 'フォローを解除しました。'
    end
    # it 'フォロー解除に失敗する' do
    #   post relationships_path(follow_id: user_a.id)
    #   expect(response).to redirect_to users_show_path(id: user_a.id)
    #   expect(flash[:success]).to include 'フォローしました。'
    #   Relationship.any_instance.stub(:destroy).and_return(false)
    #   delete relationship_path(user_a.id, follow_id: user_a.id)
    #   expect(response).to redirect_to users_show_path(id: user_a.id)
    #   expect(flash.now[:alert]).to include 'フォロー解除に失敗しました。'
    # end
  end
end
