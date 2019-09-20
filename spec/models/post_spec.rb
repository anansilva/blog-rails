require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#title' do
    it 'validates presence' do
      post = Post.new
      expect(post.valid?).to eq(false)
    end
  end

  describe '#body' do
    it 'validates presence' do
      post = Post.new(title: 'I have a title')
      expect(post.valid?).to eq(false)
    end
  end
end
