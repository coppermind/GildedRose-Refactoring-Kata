require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:items) { [item] }
  let(:gilded_rose) { GildedRose.new(items) }

  before { gilded_rose.update_qualities }

  describe '#update_quality' do
    # Sulfuras, Hand of Ragnaros ######
    context 'name is `Sulfuras, Hand of Ragnaros`' do
      let(:sell_in) { 20 }
      let(:quality) { 10 }
      let(:item) { Item.new('Sulfuras, Hand of Ragnaros', sell_in, quality) }
      it 'does not change sell_in' do
        expect(item.sell_in).to eql(sell_in)
      end
      it 'does not change quality values' do
        expect(item.quality).to eql(quality)
      end
    end

    # +5 Dexterity Vest ###############
    context 'name is `+5 Dexterity Vest`' do
      let(:item) { Item.new('+5 Dexterity Vest', sell_in, quality) }
      context 'when sell_in > -1 and quality > 0' do
        let(:sell_in) { 10 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'decrements quality' do
          expect(item.quality).to eql(quality - 1)
        end
      end

      context 'when sell_in < 1 and quality > 0' do
        let(:sell_in) { 0 }
        let(:quality) { 10 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'substracts 2 from quality' do
          expect(item.quality).to eql(quality - 2)
        end
      end

      context 'when sell_in < 1 and quality eql 0' do
        let(:sell_in) { 0 }
        let(:quality) { 0 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'doest not change quality' do
          expect(item.quality).to eql(quality)
        end
      end
    end

    # Elixir of the Mongoose ##########
    context 'name is `Elixir of the Mongoose`' do
      let(:item) { Item.new('Elixir of the Mongoose', sell_in, quality) }
      context 'when sell_in > -1 and quality > 0' do
        let(:sell_in) { 10 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'decrements quality' do
          expect(item.quality).to eql(quality - 1)
        end
      end

      context 'when sell_in eql 0 and quality > 0' do
        let(:sell_in) { 0 }
        let(:quality) { 10 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'substracts 2 from quality' do
          expect(item.quality).to eql(quality - 2)
        end
      end

      context 'when sell_in eql 0 and quality eql 0' do
        let(:sell_in) { 0 }
        let(:quality) { 0 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'doest not change quality' do
          expect(item.quality).to eql(quality)
        end
      end
    end

    # Aged Brie #######################
    context 'name is `Aged Brie`' do
      let(:item) { Item.new('Aged Brie', sell_in, quality) }

      context 'when sell_in > 0 and quality < 50' do
        let(:sell_in) { 1 }
        let(:quality) { 40 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 1)
        end
      end

      context 'when sell_in > -1 and quality < 50' do
        let(:sell_in) { 0 }
        let(:quality) { 40 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 2)
        end
      end

      context 'when sell_in > 0 and quality < 50' do
        let(:sell_in) { 2 }
        let(:quality) { 40 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 1)
        end
      end

      context 'when sell_in < 0 and quality eql 49' do
        let(:sell_in) { -1 }
        let(:quality) { 49 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 1)
        end
      end

      context 'when sell_in < 0 and quality <= 48' do
        let(:sell_in) { -1 }
        let(:quality) { 48 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'adds 2 to quality' do
          expect(item.quality).to eql(quality + 2)
        end
      end

      context 'when sell_in < 0 and quality eql 50' do
        let(:sell_in) { -1 }
        let(:quality) { 50 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'quality is unchanged' do
          expect(item.quality).to eql(quality)
        end
      end
    end

    # Backstage passes to a TAFKAL80ETC concert
    context 'name is `Backstage passes to a TAFKAL80ETC concert`' do
      let(:item) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality) }
      context 'when sell_in > 10' do
        let(:sell_in) { 11 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 1)
        end
      end

      context 'when sell_in < 11' do
        let(:sell_in) { 10 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'adds 2 to quality' do
          expect(item.quality).to eql(quality + 2)
        end
      end

      context 'when sell_in < 11 and quality > 48' do
        let(:sell_in) { 10 }
        let(:quality) { 49 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'sets quality to 50' do
          expect(item.quality).to eql(50)
        end
      end

      context 'when sell_in > 0 and quality > 48' do
        let(:sell_in) { 1 }
        let(:quality) { 49 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'sets quality to 50' do
          expect(item.quality).to eql(50)
        end
      end

      context 'when sell_in < 7' do
        let(:sell_in) { 6 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'adds 2 to quality' do
          expect(item.quality).to eql(quality + 2)
        end
      end

      context 'when sell_in > 4' do
        let(:sell_in) { 5 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'adds 3 to quality' do
          expect(item.quality).to eql(quality + 3)
        end
      end

      context 'when sell_in < 5 and sell_in > -1' do
        let(:sell_in) { 1 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'adds 3 to quality' do
          expect(item.quality).to eql(quality + 3)
        end
      end

      context 'when sell_in < 0' do
        let(:sell_in) { -1 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'set quality to 0' do
          expect(item.quality).to eql(0)
        end
      end
    end
  end

end
