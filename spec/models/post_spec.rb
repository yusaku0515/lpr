require 'rails_helper'

RSpec.describe Post, type: :model do #describeはテストのグループ化を宣言する
  let(:user) { create(:user) }
  let!(:post) { build(:post, user_id: user.id) }

  context "データが正しく保存される" do
    before do
      @post = Post.new
      @post.title = "Hello WebCamp"
      @post.post_text = "今日も晴れです。"
      @post.save
    end

    it "全て入力してあるので保存される" do
      expect(@post).to be_valid
    end
  end
  # context "データが正しく保存されない" do
  #   before do
  #     @post = Post.new
  #     @post.title = ""
  #     @post.post_text = "今日も晴れです。"
  #     @post.save
  #   end
  #   it "titleが入力されていないので保存されない" do
  #     expect(@post).to be_invalid
  #     expect(@post.errors[:title]).to include("can't be blank")
  #   end
end
