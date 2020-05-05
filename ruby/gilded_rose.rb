class GildedRose

  # Rule names are completely arbitrary for now while I think of a better naming convention
  # NB: `sell_in` attribute conditions are checked after decrement of `sell_in` value
  RULES = {
    decreasing_quality_floor_zero: {
      'item.sell_in > -1 && item.quality > 0': { attrib: :quality, amount: -1, operation: :add },
      'item.sell_in < 1 && item.quality > 0': { attrib: :quality, amount: -2, operation: :add },
      'item.sell_in < 1 && item.quality == 0': { attrib: :quality, amount: 0, operation: :set }
    },
    increasing_quality_ceiling_fifty: {
      'item.sell_in < 0 && item.quality >= 50': { attrib: :quality, amount: 50, operation: :set },
      'item.sell_in < 0 && item.quality == 49': { attrib: :quality, amount: 1, operation: :add },
      'item.sell_in < 0 && item.quality <= 48': { attrib: :quality, amount: 2, operation: :add },
      'item.sell_in > -1 && item.quality < 50': { attrib: :quality, amount: 1, operation: :add }
    },
    increasing_quality_floor_zero: {
      'item.sell_in < 11 && item.sell_in > -1 && item.quality > 48': { attrib: :quality, amount: 50, operation: :set },
      'item.sell_in < 0': { attrib: :quality, amount: 0, operation: :set },
      'item.sell_in < 5': { attrib: :quality, amount: 3, operation: :add },
      'item.sell_in > 9': { attrib: :quality, amount: 1, operation: :add },
      'item.sell_in < 11 && item.sell_in > 4': { attrib: :quality, amount: 2, operation: :add },
    },
    ignore: nil
  }

  def initialize(items)
    @items = items
  end

  def update(item)
    return if item.rule.nil?

    item.send(:add_sell_in, -1)
    item.rule.each do |rule, config|
      if eval(rule.to_s)
        method_name = case config[:operation]
        when :add
          "add_#{config[:attrib]}"
        when :set
          "#{config[:attrib]}="
        end
        item.send(method_name, config[:amount])
        return
      end
    end
  end

  def update_qualities
    @items.each do |item|
      update(item)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality, :rule

  def initialize(name, sell_in, quality, rule)
    @name = name
    @sell_in = sell_in
    @quality = quality
    @rule = rule
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def add_sell_in(amount)
    @sell_in += amount
  end

  def add_quality(amount)
    @quality += amount
  end
end
