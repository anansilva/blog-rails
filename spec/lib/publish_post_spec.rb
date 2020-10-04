describe Posts::PublishPost do
  context 'a draft post that is going to be published for the first time' do
    let(:post) { create(:post, status: 'draft') }

    it 'updates the post status to published' do
      described_class.call(post)

      expect(post.reload.status).to eq('published')
    end

    it 'updates the published_at date' do
      expect(post.published_at).to be_nil

      described_class.call(post)

      expect(post.reload.published_at >= Date.today).to be_truthy
    end
  end

  context 'a draft post that has been published before' do
    let(:post) { create(:post, status: 'draft', published_at: 1.month.ago) }

    it 'updates the post status to published' do
      described_class.call(post)

      expect(post.reload.status).to eq('published')
    end

    it 'does not update the published_at date' do
      described_class.call(post)

      expect(post.reload.published_at <= 1.month.ago).to be_truthy
    end
  end
end
