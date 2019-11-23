describe TagPosts::AddTagsToPost do
  describe '.execute!' do
    context 'when creating and adding new tags to the post' do
      let(:post) { create(:post) }
      let(:tags) { %w[Ruby Rails] }

      before do
        described_class.execute!(post, tags)
      end

      it 'creates the Tags' do
        expect(Tag.count).to eq(2)
      end

      it 'adds the tags to the post' do
        expect(post.tags.count).to eq(2)
      end
    end

    context 'when adding existing tags to the post' do
      let(:post) { create(:post) }

      before do
        create(:tag, name: 'Ruby')
        create(:tag, name: 'Rails')
      end

      it 'does not create new tags' do
        expect do
          described_class.execute!(post, %w[Ruby Rails])
        end.to change { Tag.count }.by(0)
      end

      it 'adds the tags to the post' do
        tags = Tag.where(name: %w[Ruby Rails])

        described_class.execute!(post, tags)

        expect(post.tags.count).to eq(2)
      end
    end

    context 'when adding existing tags that the post already has' do
      let(:post) { create(:post) }
      let(:tag_ruby) { create(:tag, name: 'Ruby') }
      let(:tag_rails) { create(:tag, name: 'Rails') }

      before do
        create(:tag_post, post: post, tag: tag_ruby)
        create(:tag_post, post: post, tag: tag_rails)
      end

      it 'does not create new tags' do
        expect do
          described_class.execute!(post, %w[Ruby Rails])
        end.to change { Tag.count }.by(0)
      end

      it 'adds the tags to the post' do
        expect do
          described_class.execute!(post, %w[Ruby Rails])
        end.to change { TagPost.count }.by(0)
      end
    end
  end
end
