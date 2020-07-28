require 'rails_helper'

RSpec.describe Post, type: :model do #describeはテストのグループ化を宣言する
  let(:user) { create(:user) }
  let!(:post) { build(:post, user_id: user.id) }

  describe 'バリデーションのテスト' do
    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        expect(post.valid?).to eq false;
      end
    end
    context 'post_textカラム' do
      it '空欄でないこと' do
        post.post_text = ''
        expect(post.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
