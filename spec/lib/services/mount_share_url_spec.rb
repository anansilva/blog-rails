describe Services::MountShareUrl do
  let(:post) { create(:post) }
  let(:post_url) { "http://localhost/posts/sample-post-title" }

  context 'twitter' do
    it 'mounts the twitter url ' do
      result = described_class.call(post, post_url, 'twitter')

      expect(result).to eq("https://twitter.com/intent/tweet?url=http://localhost/posts/sample-post-title&text=Intro")
    end
  end

  context 'facebook' do
    it 'mounts the twitter url ' do
      result = described_class.call(post, post_url, 'facebook')

      expect(result).to eq("http://www.facebook.com/sharer.php?u=http://localhost/posts/sample-post-title&p[title]=Intro")
    end
  end

  context 'linkedin' do
    it 'mounts the linkedin url ' do
      result = described_class.call(post, post_url, 'linkedin')

      expect(result).to eq("https://www.linkedin.com/shareArticle?mini=true&url=http://localhost/posts/sample-post-title&text=Intro")
    end
  end
end
