describe SpaceMonkey::Client do
  let(:example_url) { 'https://example.com' }
  it 'accepts options' do
    client = described_class.new(url: example_url)
    expect(client.connection.options).to eq(url: example_url)
  end

  it 'has a connection' do
    client = described_class.new
    expect(client.connection).to be_a(SpaceMonkey::Connection)
  end

  it 'has an account client' do
    expect(subject.account).to be_an(SpaceMonkey::Account)
    expect(subject.account.connection).to be(subject.connection)
  end
end
