require 'rails_helper'
RSpec.describe 'サンプル', type: :system do
  describe 'サンプル' do
    context 'サンプル' do
      it 'サンプル' do
        visit root_path
        expect(current_path).to eq root_path
        expect(page).to have_content 'idimo'
        click_on '新規登録'
        expect(page).to have_content 'パスワード'
      end
    end
  end
end
