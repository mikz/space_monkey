require 'json'

describe SpaceMonkey::AccountClient do
  let(:connection) { SpaceMonkey.connection }
  subject(:account) { SpaceMonkey::AccountClient.new(connection) }

  it 'logins' do
    login = stub_request(:post, 'https://accounts.spacemonkey.com/login').with(body: {email: 'username', password: 'password'}).
        to_return(headers: { 'Set-Cookie' =>  'Set-Cookie:session="XXXXX/xxxxx=?_fresh=xxxxxx=&_id=xxxxxxxxxxx==&user_id=xxxxxx=="; Domain=.spacemonkey.com; Path=/; HttpOnly' })
    subject.login('username', 'password')
    expect(login).to have_been_made
  end

  it 'raises exception when login is not successful' do
    stub_request(:post, 'https://accounts.spacemonkey.com/login').to_return(status: 401)
    expect { subject.login('e', 'p') }.to raise_error(SpaceMonkey::AccountClient::LoginError)
  end

  it 'gets account info' do
    json = { 'email' => 'test@example.com', 'billing_address' => 'Some Address' }
    info = stub_request(:get, 'https://accounts.spacemonkey.com/users/self').
        to_return(body: json.to_json, headers: { 'Content-Type' => 'application/json' })
    expect(account.info).to eq(json)
    expect(info).to have_been_made
  end
end
