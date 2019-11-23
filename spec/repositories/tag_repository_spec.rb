describe TagRepository do
  describe '.create_bulk' do
    it 'creates multiple tags when attrs are valid' do
      attrs = [{ name: 'ruby' }, { name: 'rails' }]

      described_class.create_bulk(attrs)

      expect(Tag.count).to eq(2)
    end

    it 'raises error when attrs are invalid' do
      attrs = [{ tag: 'ruby' }]

      expect do
        described_class.create_bulk(attrs)
      end.to raise_error(Errors::InvalidAttributes)
    end
  end
end
