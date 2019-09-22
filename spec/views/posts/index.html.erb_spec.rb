describe 'posts/index.html.erb' do
  context 'when there are no posts' do
    it 'displays empty index message' do
      assign(:posts, [])

      render

      expect(rendered).to match('You have no posts')
    end
  end
end
