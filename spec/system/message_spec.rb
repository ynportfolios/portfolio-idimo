require 'rails_helper'
RSpec.describe 'ダイレクトメッセージ関連機能', type: :system do
  let(:user) { create(:user, profile: 'こんにちは') }
  let(:user_a) { create(:user_a, profile: 'こんにちは') }
  let(:user_b) { create(:user_b, profile: 'おはようございます') }

  describe 'ダイレクトメッセージ機能' do
    before do
      user_a.confirm
      user_b.confirm
    end
    context 'ダイレクトメッセージ画面へ遷移する' do
      it 'メッセージが送信できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        click_on 'testuser_a'
        click_on 'ダイレクトメッセージへ'
        (all('.form-control')[0]).set('はじめまして')
        find('input[type="submit"]').click
        click_on 'ログアウト'
        click_on 'ログイン'
        fill_in 'Eメール', with: user_a.email
        fill_in 'パスワード', with: user_a.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        click_on 'testuser_b'
        click_on 'ダイレクトメッセージへ'
        expect(page).to have_content 'はじめまして'
        expect(page).to have_content 'testuser_bさん'
      end
    end
  end
end
