require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:min_quality) { 0 }
  let(:max_quality) { 50 }
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

    # Conjured Items ##################
    context 'ConjuredItem' do
      [ '+5 Dexterity Vest', 'Elixir of the Mongoose', 'Conjured Mana Cake' ].each do |name|
        let(:item) { Item.new(name, sell_in, quality) }
        context 'when sell_in > 0 and quality > 0' do
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

        context 'when sell_in < 1 and quality is 0' do
          let(:sell_in) { -2 }
          let(:quality) { 0 }
          it 'decrements sell_in' do
            expect(item.sell_in).to eql(sell_in - 1)
          end
          it 'doest not change quality' do
            expect(item.quality).to eql(min_quality)
          end
        end
      end
    end

    # Aged Brie #######################
    context 'AgedBrieItem' do
      let(:item) { Item.new('Aged Brie', sell_in, quality) }

      context 'when sell_in > 0' do
        let(:sell_in) { 1 }
        let(:quality) { 40 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 1)
        end
      end

      context 'when sell_in < 1' do
        let(:sell_in) { 0 }
        let(:quality) { 40 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(quality + 2)
        end
      end

      context 'when sell_in < 1 and quality is 49' do
        let(:sell_in) { -1 }
        let(:quality) { 49 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'increments quality' do
          expect(item.quality).to eql(max_quality)
        end
      end

      context 'when sell_in < 0 and quality is 50' do
        let(:sell_in) { -1 }
        let(:quality) { 50 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'quality is unchanged' do
          expect(item.quality).to eql(max_quality)
        end
      end
    end

    # BackstagePassItem ###############
    context 'BackstagePassItem' do
      let(:item) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality) }
      context 'when sell_in > 11' do
        let(:sell_in) { 12 }
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

      context 'when sell_in < 6' do
        let(:sell_in) { 5 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'adds 3 to quality' do
          expect(item.quality).to eql(quality + 3)
        end
      end

      context 'when sell_in < 11 and quality is 49' do
        let(:sell_in) { 10 }
        let(:quality) { 49 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'sets quality to max' do
          expect(item.quality).to eql(max_quality)
        end
      end

      context 'when sell_in < 3 and quality > 48' do
        let(:sell_in) { 1 }
        let(:quality) { 49 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'sets quality to max' do
          expect(item.quality).to eql(max_quality)
        end
      end

      context 'when sell_in < 0' do
        let(:sell_in) { -1 }
        let(:quality) { 20 }
        it 'decrements sell_in' do
          expect(item.sell_in).to eql(sell_in - 1)
        end
        it 'set quality to 0' do
          expect(item.quality).to eql(min_quality)
        end
      end
    end
  end

end
