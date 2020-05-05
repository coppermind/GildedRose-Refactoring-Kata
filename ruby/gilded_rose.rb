class GildedRose
  def initialize(items)
    @items = []
    items.each do |item|
      @items << IdentifyItem.(item)
    end
  end

  def update(item)
    return if item.class::RULES.empty?

    item.send(:age_item)
    item.class::RULES.each do |rule, config|
      if eval(rule.to_s)
        method_name = case config[:operation]
        when :add
          "add_quality"
        when :set
          "quality="
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
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class IdentifyItem
  def self.call(item)
    case item.name
    when '+5 Dexterity Vest', 'Elixir of the Mongoose', 'Conjured Mana Cake'
      ConjuredItem.new(item)
    when 'Aged Brie'
      SoftCheeseItem.new(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePassItem.new(item)
    when 'Sulfuras, Hand of Ragnaros'
      SulfurasWeaponItem.new(item)
    end
  end
end

class CommonAttributes

  def initialize(item)
    @item = item
  end

  def age_item
    @item.sell_in -= 1
  end

  def add_quality(amount)
    @item.quality += amount
  end

  def sell_in
    @item.sell_in
  end

  def quality
    @item.quality
  end

  def quality=(amount)
    @item.quality = amount
  end
end

class ConjuredItem < CommonAttributes
  RULES = {
    'item.sell_in > -1 && item.quality > 0': { amount: -1, operation: :add },
    'item.sell_in < 1 && item.quality > 0': { amount: -2, operation: :add },
    'item.sell_in < 1 && item.quality == 0': { amount: 0, operation: :set }
  }.freeze
end

class SoftCheeseItem < CommonAttributes
  RULES = {
    'item.sell_in < 0 && item.quality >= 50': { amount: 50, operation: :set },
    'item.sell_in < 0 && item.quality == 49': { amount: 1, operation: :add },
    'item.sell_in < 0 && item.quality <= 48': { amount: 2, operation: :add },
    'item.sell_in > -1 && item.quality < 50': { amount: 1, operation: :add }
  }.freeze
end

class BackstagePassItem < CommonAttributes
  RULES = {
    'item.sell_in < 11 && item.sell_in > -1 && item.quality > 48': { amount: 50, operation: :set },
    'item.sell_in < 0': { amount: 0, operation: :set },
    'item.sell_in < 5': { amount: 3, operation: :add },
    'item.sell_in > 9': { amount: 1, operation: :add },
    'item.sell_in < 11 && item.sell_in > 4': { amount: 2, operation: :add }
  }.freeze
end

class SulfurasWeaponItem < CommonAttributes
  RULES = { }.freeze
end
