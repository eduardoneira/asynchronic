module DataStoreExamples
  
  it 'Get/Set value' do
    data_store.set 'test_key', 123
    data_store.get('test_key').must_equal 123
  end

  it 'Key not found' do
    data_store.get('test_key').must_be_nil
  end

  it 'Keys' do
    data_store.keys.must_be_empty
    data_store.set 'test_key', 123
    data_store.keys.must_equal ['test_key']
  end

  it 'Merge' do
    data_store.set 'a:1', 0
    data_store.merge 'a', '1' => 1, '2' => 2

    data_store.get('a:1').must_equal 1
    data_store.get('a:2').must_equal 2
  end

  it 'To hash' do
    data_store.set 'a', 0
    data_store.set 'a:1', 1
    data_store.set 'a:2', 2
    data_store.set 'b:3', 3

    data_store.to_hash('a').must_equal '1' => 1, '2' => 2
  end

  it 'Nested keys' do
    data_store.set 'a', 0
    data_store.set 'a:1', 1
    data_store.set 'a:2', 2
    data_store.set 'b:3', 3

    data_store.keys('a').must_equal_contents %w(a a:1 a:2)
    data_store.keys('a:').must_equal_contents %w(a:1 a:2)
  end

  it 'Clear' do
    data_store.set 'test_key', 123
    data_store.clear
    data_store.keys.must_be_empty
  end

  it 'Nested clear' do
    data_store.set 'a', 0
    data_store.set 'a:1', 1
    data_store.set 'a:2', 2
    data_store.set 'b:3', 3

    data_store.clear 'a:'

    data_store.keys.must_equal_contents %w(a b:3)
  end
  
end