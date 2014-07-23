describe SpaceMonkey::Inode do
  it 'should has inode and parent' do
    parent = directory
    inode = described_class.new('id', file, parent)
    expect(inode.parent).to be(parent)
  end
end


describe SpaceMonkey::Inode::Path do
  it 'builds inodes with parent' do
    path = described_class.new(inodes)
    expect(path.to_s).to eq('home/test_dir/test_file')
  end
end
