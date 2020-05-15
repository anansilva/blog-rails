RSpec.describe Tag, type: :model do
  describe 'associations' do
    let(:tag) { build(:tag) }

    it 'has many tag_posts' do
      expect(tag.tag_posts).to eq([])
    end

    it 'has many posts through tags' do
      expect(tag.posts).to eq([])
    end
  end

  describe 'validations' do
    subject { described_class.new(name: 'ruby') }

    it 'is valid with a name' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil

      expect(subject).to_not be_valid
    end

    it 'has uniq names' do
      subject.save

      expect(Tag.new(name: 'ruby')).to_not be_valid
    end
  end
end
