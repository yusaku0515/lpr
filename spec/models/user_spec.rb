require 'rails_helper'

RSpec.describe PostController, :type => :controller do
  describe "GET #show" do
    # userをFactoryGirlで作る
    let(:user) { FactoryGirl.build(:user) }

    　　 # 作ったユーザでログインする
    before do
      login_user user
    end

    it "can get it" do
      get :show, id: 1

      # 出力結果
      p response
    end
  end
end
