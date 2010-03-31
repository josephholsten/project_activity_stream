class HashWithAppend < Hash
  
  # Adds a new key/value pair to an existing Hash. If the key to be added
  # already exists and the existing value associated with key is not
  # an Array, it will be wrapped in an Array. Then the new value is
  # appended to that Array.
  #
  # hash::
  #   Hash to add key/value pair to.
  # key::
  #   Key to be added.
  # value::
  #   Value to be associated with key.
  def []=(key, value)
    if has_key?(key)
      if self[key].instance_of?(Array)
        self[key] << value
      else
        super(key, [self[key], value])
      end
    elsif value.instance_of?(Array)
      super(key, [value])
    else
      super(key, value)
    end
    self
  end
end

class Hash
  def with_append
    hash = HashWithAppend.new(self)
    hash.default = self.default
    hash
  end
end