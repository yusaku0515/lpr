require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  let(:user) { create(:user) }

  describe 'バリデーションのテスト' do
    context 'emailカラム' do
      it '空欄でない事' do
        email = ''
        expect(contact.valid?).to eq false;
      end
    end
    context 'messageカラム' do
      it '空欄でない事' do
        message = ''
        expect(message.valid?).to eq false;
      end
    end
  end
end