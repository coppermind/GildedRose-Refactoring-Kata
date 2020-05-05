#!/usr/bin/ruby -w

require File.join(File.dirname(__FILE__), 'gilded_rose')

puts "OMGHAI!"
items = [
  Item.new(name="+5 Dexterity Vest", sell_in=10, quality=15, GildedRose::RULES[:decreasing_quality_floor_zero]),
  Item.new(name="Aged Brie", sell_in=2, quality=41, GildedRose::RULES[:increasing_quality_ceiling_fifty]),
  Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7, GildedRose::RULES[:decreasing_quality_floor_zero]),
  Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80, GildedRose::RULES[:ignore]),
  Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80, GildedRose::RULES[:ignore]),
  Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=-10, GildedRose::RULES[:increasing_quality_floor_zero]),
  Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49, GildedRose::RULES[:increasing_quality_floor_zero]),
  Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49, GildedRose::RULES[:increasing_quality_floor_zero]),
  # This Conjured item does not work properly yet
  # Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
]

days = 2
if ARGV.size > 0
  days = ARGV[0].to_i + 1
end

gilded_rose = GildedRose.new items
(0...days).each do |day|
  puts "-------- day #{day} --------"
  puts "name, sellIn, quality"
  items.each do |item|
    puts item
  end
  puts ""
  gilded_rose.update_qualities
end
