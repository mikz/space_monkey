describe SpaceMonkey::ShareClient do
  it 'creates a share' do
    request = stub_request(:post, "https://api.spacemonkey.com/v1/shares/path/some/path%20and%20stuff.jpg").
        to_return(body: {
                    filename: "path and stuff.jpg",
                    path: "/some/path and stuff.jpg",
                    type: "FILE",
                    sharetype: "PLAIN",
                    share_id: "OH8tdf68hkshBJ-7-6RoQw",
                    share_name: "39edf358f9bed3ae4cef4ff76706802a3fdca49dda068ef335d1d048b30aa1b8"
                  }.to_json,
                  headers: { 'Content-Type' => 'application/json' } )

    share = subject.file('some/path and stuff.jpg')

    expect(share.path).to eq('/some/path and stuff.jpg')
    expect(request).to have_been_made
  end
end
