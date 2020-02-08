describe Query::Posts do
  before 'create posts and tags' do
    create(:post, status: 'published')
    create(:post, status: 'draft')

    create(:post, status: 'published').tap do |post|
      create(:tag, name: 'ruby').tap do |tag|
        create(:tag_post, tag: tag, post: post)
      end
    end

    create(:post, status: 'draft').tap do |post|
        create(:tag_post, tag: Tag.first, post: post)
    end
  end

  context 'when filtering by published posts' do
    context 'when tag is empty' do
      it 'returns all published posts' do
        filtered_posts = described_class.call(nil, 'published')

        expect(filtered_posts.count).to eq(2)
      end
    end

    context 'when tag exists' do
      it 'returns only the published posts that are related to the tag' do
        filtered_posts = described_class.call('ruby', 'published')

        expect(filtered_posts.count).to eq(1)
      end
    end
  end

  context 'when not filtering by status nor tags' do
    it 'returns all the posts' do
      filtered_posts = described_class.call

      expect(filtered_posts.count).to eq(4)
    end
  end

  context 'when only filtering by tag' do
    it 'returns all the posts (draft and published) with that tag' do
      filtered_posts = described_class.call('ruby')

      expect(filtered_posts.count).to eq(2)
    end
  end
end
