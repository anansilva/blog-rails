describe Tags::UpdatePostTags do
  describe '.execute!' do
    let(:post) { create(:post) }
    let(:tag_ruby) { create(:tag, name: 'ruby') }
    let(:tag_rails) { create(:tag, name: 'rails') }

    before do
      create(:tag_post, post: post, tag: tag_ruby)
      create(:tag_post, post: post, tag: tag_rails)
    end

    context 'when the tags remain equal' do
      it 'does not add those tags to the post' do
        tags = %w[ruby rails]

        described_class.execute!(post, tags)

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array(%w[ruby rails])
      end
    end

    context 'when adding tags' do
      it 'adds the new tags to the existing ones' do
        tags = %w[ruby rails rspec]

        described_class.execute!(post, tags)

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array(%w[ruby rails rspec])
      end
    end

    context 'when removing tags' do
      it 'adds the new tags to the existing ones' do
        described_class.execute!(post, [])

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array([])
      end
    end

    context 'when adding and removing tags at the same time' do
      let(:tags) { %w[rails rspec] }

      before { described_class.execute!(post, tags) }

      it 'removes the tags not included in the new array' do
        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).not_to include('ruby')
      end

      it 'adds the new tags' do
        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to include('rspec')
      end

      it 'keeps the untouched tags' do
        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to include('rails')
      end
    end
  end
end
