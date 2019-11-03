require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#title' do
    it 'validates presence' do
      post_without_title = Post.new(body: 'I have a body')

      expect(post_without_title.valid?).to eq(false)
    end
  end

  describe '#body' do
    it 'validates presence' do
      post_without_body = Post.new(title: 'I have a title')
      post_with_body = Post.new(title: 'I have a title', body: 'and a body')

      expect(post_without_body.valid?).to eq(false)
      expect(post_with_body.valid?).to eq(true)
    end
  end

  describe '#intro' do
    it 'validates that length is at most 255' do
      invalid_intro = Array.new(256){ [*'A'..'Z', *'0'..'9'].sample }.join
      valid_intro = 'valid intro'
      post_with_big_intro = Post.new(title: 'I have a title', body: 'hi',
                                     intro: invalid_intro)
      post_with_valid_intro = Post.new(title: 'I have a title', body: 'hi',
                                       intro: valid_intro)

      expect(post_with_big_intro.valid?).to eq(false)
      expect(post_with_valid_intro.valid?).to eq(true)
    end
  end
end
