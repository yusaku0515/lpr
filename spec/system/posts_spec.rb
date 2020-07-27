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
	describe '投稿ページの表示〜投稿するまでのテスト' do
		context '投稿ページの確認' do
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

	describe '詳細画面のテスト' do
		context '自分・他人共通の投稿詳細ページの表示' do
			it '投稿詳細と表示される' do
				visit post_path(post)
				expect(page).to have_content '投稿詳細'
			end
			it 'ユーザー名・リンク先が正しい' do
	  			visit post_path(post)
	  			expect(page).to have_link post.user.company_name, href: user_path(post.user)
	  		end
	  		it '投稿のタイトルが表示される' do
	  			visit post_path(post)
	  			expect(page).to have_content post.title
	  		end
	  		it '投稿の本文が表示される' do
	  			visit post_path(post)
	  			expect(page).to have_content post.post_text
	  		end
		end
		context '自分の投稿詳細画面の表示を確認' do
	  		it '投稿の編集リンクが表示される' do
	  			visit post_path post
	  			expect(page).to have_link '編集', href: edit_post_path(post)
	  		end
	  		it '投稿の削除リンクが表示される' do
	  			visit post_path post
	  			expect(page).to have_link '削除', href: post_path(post)
	  		end
	  	end
	  	context '他人の投稿詳細画面の表示を確認' do
	  		it '投稿の編集リンクが表示されない' do
	  			visit post_path(post2)
	  			expect(page).to have_no_link '編集', href: edit_post_path(post2)
	  		end
	  		it '投稿の削除リンクが表示されない' do
	  			visit post_path(post2)
	  			expect(page).to have_no_link '削除', href: post_path(post2)
	  		end
	  	end
	end

  	describe '編集のテスト' do
	  	context '自分の投稿の編集画面への遷移' do
			it '遷移できる' do
				visit edit_post_path(post)
				expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
			end
		end
		context '他人の投稿の編集画面への遷移' do
			it '遷移できない' do
			    visit edit_post_path(post2)
			    expect(current_path).to eq('/posts')
			end
		end
		context '表示の確認' do
			before do
				visit edit_post_path(post)
			end
			it '投稿情報編集と表示される' do
				expect(page).to have_content('投稿情報編集')
			end
			it 'タイトル編集フォームが表示される' do
				expect(page).to have_field 'post[title]', with: post.title
			end
			it '本文編集フォームが表示される' do
				expect(page).to have_field 'post[post_text]', with: post.post_text
			end
			# it 'Showリンクが表示される' do
			# 	expect(page).to have_link 'Show', href: post_path(book)
			# end
			# it 'Backリンクが表示される' do
			# 	expect(page).to have_link 'Back', href: posts_path
			# end
		end
		context 'フォームの確認' do
			it '編集に成功する' do
				visit edit_post_path(post)
				click_button '変更を保存する'
				expect(page).to have_content '投稿の編集内容を更新しました'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
			it '編集に失敗する' do
				visit edit_post_path(post)
				fill_in 'post[title]', with: ''
				click_button '変更を保存する'
				expect(page).to have_content 'エラーが発生しました'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
		end
	end

	# describe '一覧画面のテスト' do
	# 	before do
	# 		visit posts_path
	# 	end
	# 	context '表示の確認' do
	# 		it '自分と他人の画像のリンク先が正しい' do
	# 			expect(page).to have_link '', href: user_path(book.user)
	# 			expect(page).to have_link '', href: user_path(book2.user)
	# 		end
	# 		it '自分と他人のタイトルのリンク先が正しい' do
	# 			expect(page).to have_link book.title, href: book_path(book)
	# 			expect(page).to have_link book2.title, href: book_path(book2)
	# 		end
	# 		it '自分と他人のオピニオンが表示される' do
	# 			expect(page).to have_content book.body
	# 			expect(page).to have_content book2.body
	# 		end
	# 	end
	# end
end