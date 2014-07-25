# SpaceMonkey [![Build Status](https://travis-ci.org/mikz/space_monkey.svg)](https://travis-ci.org/mikz/space_monkey) [![Coverage Status](https://img.shields.io/coveralls/mikz/space_monkey.svg)](https://coveralls.io/r/mikz/space_monkey)

Ruby Client for Space Monkey API.

Experimental. Space Monkey API is not public yet and it can change any time.

## Installation

Add this line to your application's Gemfile:

    gem 'space_monkey'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install space_monkey

## Usage

### Downloading a file

```ruby
client = SpaceMonkey::Client.new
client.login('email@example.com', 'password')

photos = client.inode.path('Photos')

first_photo = client.photos.entries.first 

File.open(first_photo.name, 'wb') do |file|
  file.write client.file.download(first_photo, network_reads: true)
end
```

### Uploading a file

```ruby
client = SpaceMonkey::Client.new
client.account.login('email@example.com', 'password')

photos = client.inode.home

file = client.file.new(name: 'somefile.jpg')
io = File.open('to_upload.jpg')

uploaded = client.file.upload(file, inode, io)
```


## What is supported

- [x] Downloads
- [x] Uploads
- [x] Thumbnails
- [x] Sharing
- [ ] Moving
- [ ] Deleting
- [ ] Bulk Actions

## TODO

1. figure out how to stream files
   httpclient allows it, but faraday does not
2. create fake server for testing

## Contributing

1. Fork it ( https://github.com/mikz/space_monkey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
