require 'rails_helper'
RSpec.describe 'ユーザ関連機能', type: :system do
  let(:user) { create(:user, profile: 'こんにちは') }
  let(:user_a) { create(:user_a, profile: 'こんにちは') }
  let(:user_b) { create(:user_b, profile: 'おはようございます') }

  describe 'ログイン機能' do
    before do
      user.confirm
    end
    context 'Eメール・パスワードを入力する' do
      it 'ログインできる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user.email
        fill_in 'パスワード', with: user.password
        find('input[type="submit"]').click
        expect(page).to have_content 'ログインしました。'
      end
    end
  end
  describe 'ユーザ新規登録機能' do
    context 'Eメール、ユーザ名、好きな動物、性別、生年月日、パスワード入力する' do
      it '新規登録ができる' do
        visit root_path
        click_on '新規登録'
        fill_in 'ユーザ名', with: 'テスト'
        fill_in '好きな動物', with: 'イヌ'
        fill_in 'Eメール', with: 'test@gmail.com'
        fill_in '生年月日', with: '01-01-1980'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        find('input[type="submit"]').click
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end
    end
  end
  describe 'ユーザ編集機能' do
    before do
      user_a.confirm
    end
    context 'Eメール、ユーザ名、好きな動物、性別、生年月日、パスワード以外にプロフィール画像、自己紹介を入力する' do
      it '編集できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_a.email
        fill_in 'パスワード', with: user_a.password
        find('input[type="submit"]').click
        click_on 'アカウント編集'
        attach_file 'user[image]', "#{Rails.root}/spec/files/photo_sample_1.png"
        fill_in '自己紹介', with: 'おはようございます'
        fill_in '現在のパスワード', with: user_a.password
        click_on '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end
  end
  describe 'ユーザ一覧表示・検索機能' do
    before do
      user_a.confirm
      user_b.confirm
    end
    context 'ユーザ一検索画面に遷移する' do
      it '各ユーザのユーザ名、好きな動物、自己紹介が表示される' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'おはようございます'
      end
      it 'キーワード（ユーザ名）で検索できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        (all('.form-control')[0]).set(user_b.name)
        find('input[type="submit"]').click
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'おはようございます'
        expect(page).to_not have_content 'testuser_a'
        expect(page).to_not have_content 'イヌ'
        expect(page).to_not have_content 'こんにちは'
      end
      it 'キーワード（好きな動物）で検索できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        (all('.form-control')[0]).set(user_b.animal)
        find('input[type="submit"]').click
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'おはようございます'
        expect(page).to_not have_content 'testuser_a'
        expect(page).to_not have_content 'イヌ'
        expect(page).to_not have_content 'こんにちは'
      end
      it 'キーワード（自己紹介）で検索できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        (all('.form-control')[0]).set(user_b.profile)
        find('input[type="submit"]').click
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'おはようございます'
        expect(page).to_not have_content 'testuser_a'
        expect(page).to_not have_content 'イヌ'
        expect(page).to_not have_content 'こんにちは'
      end
      it '性別で検索できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        choose 'other'
        find('input[type="submit"]').click
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'おはようございます'
        expect(page).to_not have_content 'testuser_a'
        expect(page).to_not have_content 'イヌ'
        expect(page).to_not have_content 'こんにちは'
      end
      it '生年月日で検索できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        (all('.form-control')[1]).set('01-01-1980')
        (all('.form-control')[2]).set('01-02-1980')
        find('input[type="submit"]').click
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'おはようございます'
        expect(page).to_not have_content 'testuser_a'
        expect(page).to_not have_content 'イヌ'
        expect(page).to_not have_content 'こんにちは'
      end
    end
  end
  describe 'ユーザ詳細表示機能' do
    before do
      user_a.confirm
      user_b.confirm
    end
    context 'ユーザ一詳細表示画面に遷移する' do
      it 'ユーザ名、好きな動物、性別、年齢、自己紹介を表示される' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'マイプロフィール'
        expect(page).to have_content 'testuser_b'
        expect(page).to have_content 'ネコ'
        expect(page).to have_content 'その他'
        expect(page).to have_content '41歳'
        expect(page).to have_content 'おはようございます'
      end
      it '相互フォロー時または自分自身のプロフィールである場合、該当ユーザのプロフィール画像を表示できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        click_on 'testuser_a'
        click_on 'フォローする'
        expect(page).to have_content 'フォローしました。'
        click_on 'ログアウト'
        click_on 'ログイン'
        fill_in 'Eメール', with: user_a.email
        fill_in 'パスワード', with: user_a.password
        find('input[type="submit"]').click
        click_on 'アカウント編集'
        attach_file 'user[image]', "#{Rails.root}/spec/files/photo_sample_1.png"
        fill_in '自己紹介', with: 'おはようございます'
        fill_in '現在のパスワード', with: user_a.password
        click_on '更新'
        click_on 'ユーザ検索'
        click_on 'testuser_b'
        click_on 'フォローする'
        click_on 'ログアウト'
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        click_on 'testuser_a'
        expect(page).to have_selector("img[src$='photo_sample_1.png']")
      end
      it 'フォロー・フォロー解除をできる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        click_on 'testuser_a'
        click_on 'フォローする'
        expect(page).to have_content 'フォローしました。'
        click_on 'フォロー解除'
        expect(page).to have_content 'フォローを解除しました。'
      end
      it 'ダイレクトメッセージ画面へ遷移できる' do
        visit root_path
        click_on 'ログイン'
        fill_in 'Eメール', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        find('input[type="submit"]').click
        click_on 'ユーザ検索'
        click_on 'testuser_a'
        click_on 'ダイレクトメッセージへ'
        expect(page).to have_content 'メッセージを入力してください'
      end
    end
  end
end
