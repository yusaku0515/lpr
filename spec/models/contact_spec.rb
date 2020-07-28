require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:post) { build(:post, user_id: user.id) }
  describe 'バリデーションのテスト' do
    context 'emailカラム' do
      it '空欄でない事' do
        email = ''
        expect(post.valid?).to eq false;
      end
    end
  end
end