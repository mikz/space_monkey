describe SpaceMonkey::InodeClient do

  subject(:inode) {  described_class.new(SpaceMonkey.connection) }

  let(:body_fixture) {
    { inodes: [ home_folder, test_folder ] }.to_json
  }

  let(:home_folder) {
    { content_id: SecureRandom.base64(40), inode: { metadata: {type: 'DIR', mode: 493, ctime: 1402770037291673, mtime: 1402999451574195, "crtime"=>1402770037291673, "generation_id"=>15}, "dir_ents"=>[{"name"=>"test_folder", "synced"=>true, "content_id"=>SecureRandom.base64(40), "type"=>"DIR"}]}}
  }
  let(:test_folder) {
    { "content_id"=> SecureRandom.base64(40), "inode"=>{"metadata"=>{"type"=>"DIR", "mode"=>493, "ctime"=>1402898284120782, "mtime"=>1402898284120782, "crtime"=>1402898283462378, "generation_id"=>2}, "dir_ents"=>[{"name"=>"some_image.jpg", "synced"=>true, "content_id"=>SecureRandom.base64(40), "type"=>"FILE"}]}}
  }

  it 'gets home' do
    request = stub_request(:get, 'https://api.spacemonkey.com/v1/inode/home?metadata_only=1').
        to_return(headers: {'Content-Type' => 'application/json'}, body: body_fixture)
    inode.home
    expect(request).to have_been_made
  end

  it 'gets any path' do
    request = stub_request(:get, 'https://api.spacemonkey.com/v1/inode/home/test/path?metadata_only=1').
        to_return(headers: {'Content-Type' => 'application/json'}, body: body_fixture)
    node = inode.path('test/path')
    expect(request).to have_been_made
    expect(node).to be_a(SpaceMonkey::Inode)
  end
end
