describe TagPostRepository do
  describe '.create_tag_post' do
    let(:tag) { create(:tag) }
    let(:post) { create(:post) }

    it 'adds tag to the post' do
      described_class.create_tag_post(post, tag)

      expect(TagPost.count).to eq(1)
    end
  end
end
