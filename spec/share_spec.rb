describe SpaceMonkey::Share do
  subject(:share) { described_class.new(share_id: 'shareid', filename: 'file.txt')}

  it 'has url' do
    expect(share.url.to_s).to eq('https://beta.spacemonkey.com/shares/file.txt')
  end

  it 'has link' do
    expect(share.link.to_s).to eq('https://beta.spacemonkey.com/shares/file.txt.html')
  end
end
