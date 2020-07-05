describe Tags::UpdatePostTags do
  describe '.call' do
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

        described_class.call(post, tags)

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array(%w[ruby rails])
      end
    end

    context 'when adding tags' do
      it 'adds the new tags to the existing post tags' do
        tags = %w[ruby rails rspec]

        described_class.call(post, tags)

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array(%w[ruby rails rspec])
      end
    end

    context 'when removing tags' do
      it 'removes the tag(s) form the list of post tags' do
        described_class.call(post, [])

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array([])
        expect(Tag.count).to eq(0)
      end

      it 'does not delete the tags if they are used by other posts' do
        rails_post = create(:post)
        create(:tag_post, post: rails_post, tag: tag_rails)

        described_class.call(post, [])

        tags_after_update = post.tags.pluck(:name)

        expect(tags_after_update).to match_array([])
        expect(Tag.count).to eq(1)

      end
    end

    context 'when adding and removing tags at the same time' do
      let(:tags) { %w[rails rspec] }

      before { described_class.call(post, tags) }

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
