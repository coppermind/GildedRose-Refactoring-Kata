class GildedRose
  def initialize(items)
    @items = []
    items.each do |item|
      @items << IdentifyItem.(item)
    end
  end

  def update(item)
    item.age_item
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
      AgedBrieItem.new(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePassItem.new(item)
    when 'Sulfuras, Hand of Ragnaros'
      SulfurasWeaponItem.new(item)
    end
  end
end

class CommonItemAttributes
  MIN_QUALITY = 0
  MAX_QUALITY = 50

  def initialize(item)
    @item = item
  end

  def age_item
    @item.sell_in -= 1
    update_quality
  end

  def update_quality
    @item.quality -= @item.sell_in >= 0 ? 1 : 2
    @item.quality = MIN_QUALITY if @item.quality < MIN_QUALITY
  end
end

class ConjuredItem < CommonItemAttributes
end

class AgedBrieItem < CommonItemAttributes
  def update_quality
    @item.quality += @item.sell_in >= 0 ? 1 : 2
    @item.quality = MAX_QUALITY if @item.quality > MAX_QUALITY
  end
end

class BackstagePassItem < CommonItemAttributes
  def update_quality
    if @item.sell_in < 0
      @item.quality = MIN_QUALITY
    elsif @item.sell_in < 6
      @item.quality += 3
    elsif @item.sell_in < 11
      @item.quality += 2
    else
      @item.quality += 1
    end
    @item.quality = MAX_QUALITY if @item.quality > MAX_QUALITY
  end
end

class SulfurasWeaponItem < CommonItemAttributes
  def age_item
  end
end
