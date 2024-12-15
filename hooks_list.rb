class HooksList < Array
  class Item < Struct.new(:key, :component_class); end

  class KeyNotFoundError < StandardError; end
  class WrongItemTypeError < StandardError; end
  class ItemKeyNotUniqueError < StandardError; end

  def add(item)
    raise WrongItemTypeError unless item.is_a?(Item)
    raise ItemKeyNotUniqueError if has_item_key?(item.key)

    self.push(item)
  end

  def add_before(before_key, item)
    raise WrongItemTypeError unless item.is_a?(Item)
    raise ItemKeyNotUniqueError if has_item_key?(item.key)

    index = find_item_index(before_key)
    raise KeyNotFoundError unless index

    self.insert(index, item)
  end

  def add_after(after_key, item)
    raise WrongItemTypeError unless item.is_a?(Item)
    raise ItemKeyNotUniqueError if has_item_key?(item.key)

    index = find_item_index(after_key)
    raise KeyNotFoundError unless index

    self.insert(index + 1, item)
  end

  def replace(key, item)
    raise WrongItemTypeError unless item.is_a?(Item)

    index = find_item_index(key)
    raise KeyNotFoundError unless index

    self[index] = item

    self
  end

  def get(key)
    index = find_item_index(key)
    raise KeyNotFoundError unless index

    self[index]
  end

  private

  def find_item_index(key)
    self.find_index do |item|
      item.key == key
    end
  end

  def has_item_key?(key)
    find_item_index(key) != nil
  end
end
