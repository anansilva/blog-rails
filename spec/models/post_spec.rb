RSpec.describe Post, type: :model do
  describe 'associations' do
    let(:post) { create(:post) }

    it 'has many tag posts' do
      expect(post.tag_posts).to eq([])
    end

    it 'has many tags through tag posts' do
      expect(post.tags).to eq([])
    end
  end

  describe 'validations' do
    subject do
      described_class.new(title: 'My title', body: 'My body', intro: 'My intro')
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil

      expect(subject.valid?).to eq(false)
    end

    it 'is not valid without a body' do
      subject.body = nil

      expect(subject.valid?).to eq(false)
    end

    it 'is not valid with an intro bigger than 255 chars' do
      invalid_intro = Array.new(256){ [*'A'..'Z', *'0'..'9'].sample }.join
      subject.intro = invalid_intro

      expect(subject.valid?).to eq(false)
    end
  end
end
