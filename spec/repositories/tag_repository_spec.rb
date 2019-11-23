describe TagRepository do
  describe '.create_tag' do
    it 'creates the tag if it does not yet exist' do
      described_class.create_tag('ruby')

      expect(Tag.last.name).to eq('ruby')
    end
  end
end
