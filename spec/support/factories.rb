module Factories

  def inodes
    root = directory
    subdir = directory
    f = file

    root['inode']['dir_ents'] << dir_ent(subdir['content_id'], 'dir')
    subdir['inode']['dir_ents'] << dir_ent(f['content_id'], 'file')

    { 'inodes' => [ root, subdir, f] }
  end

  def directory
    {
        'content_id' => SecureRandom.base64(40),
        'inode' => {
            'metadata' => {
                'type' => 'DIR',
                'mode' => 493,
                'ctime' => 1402770037291673,
                'mtime' => 1402999451574195,
                'crtime' => 1402770037291673,
                'generation_id' => 15
            },
            'dir_ents' => [
#                { name: 'test_folder', synced:  true, content_id: SecureRandom.base64(40), type: 'DIR' },
#                { name: 'test_file', synced:  true, content_id: SecureRandom.base64(40), type: 'FILE' }
            ]
        }
    }
  end

  def dir_ent(id, type)
    { 'name' => "test_#{type.downcase}", 'synced' =>  true, 'content_id' => id, 'type' => type.upcase }
  end

  def file
    {
        'content_id' => SecureRandom.base64(40),
        'inode' => {
            'metadata' => {
                'type' => 'FILE',
                'mode' => 420,
                'ctime' => 1402770037291673,
                'mtime' => 1402999451574195,
                'crtime' => 1402770037291673,
                'generation_id' => 5,
                'size' => 15788
            }
        }
    }
  end
end
