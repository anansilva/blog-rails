describe PostsByTagQuery do
  before 'create posts and tags' do
    create(:post)

    create(:post).tap do |post|
      create(:tag, name: 'ruby').tap do |tag|
        create(:tag_post, tag: tag, post: post)
      end
    end
  end

  context 'when tag is empty' do
    it 'returns all posts' do
      filtered_posts = described_class.new.all

      expect(filtered_posts.count).to eq(2)
    end
  end

  context 'when tag exists' do
    it 'returns only the posts that are related to the tag' do
      filtered_posts = described_class.new('ruby').all

      expect(filtered_posts.count).to eq(1)
    end
  end
end
