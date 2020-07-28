require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
	let(:user) { create(:user) }
	let!(:post) { build(:post, user_id: user.id) }

    # describe 'バリデーションのテスト', js: true do
    #     context 'commentカラム' do
    #         it '空欄でないこと' do
    #             fill_in 'comment[comment]', with: ''
    #             is_expected.to eq false;
    #         end
    #     end
	   #  context 'rateカラム' do
	   #      it '空欄でないこと' do
	   #          comment.rate = ''
	   #          is_expected.to eq false
	   #      end
	   #  end
    # end

    describe 'アソシエーションのテスト' do
        context 'Postモデルとの関係' do
            it '1:Nとなっている' do
                expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
            end
        end
        context 'Userモデルとの関係' do
            it '1:Nとなっている' do
                expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
        context 'Notificationモデルとの関係' do
            it '1:Nとなっている' do
                expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
            end
        end
    end
end
