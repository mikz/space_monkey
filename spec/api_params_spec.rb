describe SpaceMonkey::ApiParams do
  it 'should not accept unknown parameters' do
    expect { described_class.new(unknown: true) }.to raise_error(NoMethodError)
  end

  it 'transforms network_reads to 1' do
    params = described_class.new(network_reads: true)
    expect(params.network_reads).to eq(1)
  end

  it 'has metadata only by default' do
    params = described_class.new
    expect(params.to_h).to eq(metadata_only: 1)
  end
end
