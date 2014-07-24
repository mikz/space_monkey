describe SpaceMonkey::File do
  let(:content_id) { SecureRandom.base64(40) }

  it 'accepts name' do
    file = described_class.new(name: 'some name')
    expect(file.name).to eq('some name')
  end

  it 'content id' do
    file = described_class.new('content_id' => content_id)
    puts file.inspect
    expect(file.content_id).to eq(content_id)
  end

  context 'when it has content_id and name' do
    subject(:file) { described_class.new(content_id: 'id', name: 'name') }

    it 'exists' do
      expect(file).to exist
    end
  end
end
