describe SpaceMonkey::FileClient do

  let(:connection) { SpaceMonkey.connection }
  subject(:file_client) { described_class.new(connection) }

  let(:existing_file) { SpaceMonkey::File.new(content_id: 'abcdef', name: 'some_name.jpg') }

  it 'should download file' do
    request = stub_request(:get, 'https://api.spacemonkey.com/v1/file/abcdef:/some_name.jpg?metadata_only=1').
        to_return(body: '<content>')
    content = file_client.download(existing_file)

    expect(request).to have_been_made
    expect(content).to eq('<content>')
  end

  it 'gets file thumbnail' do
    request = stub_request(:get, 'https://api.spacemonkey.com/v1/thumbnail/abcdef:/some_name.jpg?metadata_only=1').
        to_return(body: '<content>')
    content = file_client.thumbnail(existing_file)

    expect(request).to have_been_made
    expect(content).to eq('<content>')
  end

  it 'cant download nonexisting file' do
    file = SpaceMonkey::File.new
    expect { file_client.download(file) }.to raise_error(SpaceMonkey::FileClient::NonExistingFile)
  end


  it 'can upload a file' do
    file = file_client.new(name: 'some name.jpg')
    io = StringIO.new('fake')
    inode = SpaceMonkey::Inode.new(SecureRandom.base64(40), {}, nil)

    stub_request(:put, "https://api.spacemonkey.com/v1/file/#{inode.content_id}/some%20name.jpg").
        with(:body => 'fake').
        to_return(body: {content_id: 'new_content_id', name: file.name}.to_json,
                  headers: {'Content-Type' => 'application/json' })

    file_client.upload(file, inode, io)
    expect(file.content_id).to eq('new_content_id')
    expect(file.name).to eq('some name.jpg')
  end
end
