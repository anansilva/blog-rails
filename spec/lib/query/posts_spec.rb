describe Query::Posts do
  context 'filters' do
    before 'create posts and tags' do
      create(:post, status: 'published', published_at: Date.today, title: 'rails 101')
      create(:post, status: 'draft')

      create(:post, status: 'published', published_at: 2.months.ago, title: 'ruby 101').tap do |post|
        create(:tag, name: 'ruby').tap do |tag|
          create(:tag_post, tag: tag, post: post)
        end
      end

      create(:post, status: 'draft').tap do |post|
          create(:tag_post, tag: Tag.first, post: post)
      end
    end

    context 'when filtering by published posts' do
      it 'returns all posts ordered by published_at date' do
        filtered_posts = described_class.call(tag: nil, status: 'published')

        expect(filtered_posts.first.title).to eq('rails 101')
        expect(filtered_posts.second.title).to eq('ruby 101')
      end

      context 'when tag is empty' do
        it 'returns all published posts' do
          filtered_posts = described_class.call(tag: nil, status: 'published')

          expect(filtered_posts.count).to eq(2)
        end
      end

      context 'when tag exists' do
        it 'returns only the published posts that are related to the tag' do
          filtered_posts = described_class.call(tag: 'ruby', status: 'published')

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
        filtered_posts = described_class.call(tag: 'ruby')

        expect(filtered_posts.count).to eq(2)
      end
    end
  end
end
