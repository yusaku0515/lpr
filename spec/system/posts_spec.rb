require 'rails_helper'

describe '投稿のテスト' do #describeはテストのグループ化を宣言する
	let(:user) { create(:user) }
	let!(:user2) { create(:user) }
	let!(:post) { create(:post, user: user) }
	let!(:post2) { create(:post, user: user2) }
	before do
		visit new_user_session_path
		fill_in 'user[email]', with: user.email
		fill_in 'user[password]', with: user.password
		click_button 'ログイン'
	    visit new_post_path
	end

	context '表示,投稿の確認' do
		it '新規投稿と表示される' do
			expect(page).to have_content '新規投稿'
		end
		it 'titleフォームが表示される' do
			expect(page).to have_field 'post[title]'
		end
		it 'post_textフォームが表示される' do
			expect(page).to have_field 'post[post_text]'
		end
		it '投稿ボタンが表示される' do
			expect(page).to have_button '投稿'
		end
		it '投稿に成功する' do
			fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
			fill_in 'post[post_text]', with: Faker::Lorem.characters(number:20)
			# fill_in 'post[tag_list]', with: Faker::Lorem.characters(number:5)
			# image
			click_button '投稿'
			expect(page).to have_content '投稿しました'
		end
		it '投稿に失敗する' do
			click_button '投稿'
			expect(page).to have_content 'エラーが発生しました'
			expect(current_path).to eq('/posts')
		end
	end
end