RSpec.describe TagPost, type: :model do
  describe 'associations' do
    let(:tagpost) { build(:tag_post) }

    it 'belongs to tags' do
      expect(tagpost.tag).to be_present
    end

    it 'belongs to post' do
      expect(tagpost.post).to be_present
    end
  end
end
