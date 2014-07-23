describe SpaceMonkey::Connection do
  it 'should sends posts' do
    request = stub_request(:post, 'https://example.com')
    subject.post('https://example.com')
    expect(request).to have_been_made
  end

  it 'remembers cookies' do
    stub_request(:post, 'https://account.example.com/login').
        to_return(headers: { 'Set-Cookie' => 'session=id; Path=/; Domain=.example.com' })
    subject.post('https://account.example.com/login')

    get_cookie = stub_request(:get, 'https://api.example.com/account').
        with(headers: { 'Cookie' =>  'session=id'})
    subject.get('https://api.example.com/account')

    expect(get_cookie).to have_been_made
  end
end
