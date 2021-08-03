require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do

  before do
    test_items = [
      Item.new("foo", 0, 0),
      Item.new("Sake", 10, 20),
      Item.new("Normal Item", 2, 10),
      Item.new("Aged Brie", 10, 20),
      Item.new("Sulfuras, Hand of Ragnaros", 0, 50),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 20),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 20),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50),
      Item.new("Aged Brie", 10, 50),
    ]
    @test = GildedRose.new(test_items)
  end

  describe "#update_quality" do
    it "does not change the name" do
      expect(@test.update_quality[0].name).to eq "foo"
    end

    context "Normal item" do
      it "quality decreases by 1 if sell_in value is >= 0" do
        expect {@test.update_quality()}.to change { @test.items[2].quality }.by(-1)
      end

      it "quality decreases by 2 if sell_in value is < 0" do
        @test.update_quality()
        expect {@test.update_quality()}.to change { @test.items[2].quality }.by(-2)
      end

      it "quality never goes below zero" do
        6.times { @test.update_quality() }
        expect {@test.update_quality()}.to change { @test.items[2].quality }.by(0)
      end

      it "SellIn decreases by 1 each day" do
        expect {@test.update_quality()}.to change { @test.items[2].sell_in }.by(-1)
      end
    end

    context "Aged Brie" do
      it "Quality increases by one each day" do
        expect {@test.update_quality()}.to change { @test.items[3].quality }.by(1)
      end

      it 'quality can not be over 50' do
        expect { @test.update_quality() }.to change { @test.items[10].quality }.by(0)
        expect(@test.items[10].quality).to eq 50

        3.times { @test.update_quality() }
        expect(@test.items[9].quality).to eq 50
      end

      it "quality increase by 2 if sell_in is less than 0" do
        11.times { @test.update_quality }
        # expect(@test.items[3].quality).to eq 30
        # expect { @test.update_quality }.to change { @test.items[3].quality }.by(2)
        expect(@test.items[3].quality).to eq 32
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "Quality stays the same" do
        6.times { @test.update_quality() }
        expect {@test.update_quality()}.to change { @test.items[4].quality }.by(0)
      end

      it "Sellin stays the same" do
        6.times { @test.update_quality() }
        expect {@test.update_quality()}.to change { @test.items[4].sell_in }.by(0)
      end
    end
    
    context "Backstage Passes" do
      it "if sellin is above 10, Quality increses by 1" do
        expect {@test.update_quality()}.to change { @test.items[5].quality }.by(1)
      end

      it "if sellin is between 10-6, Quality increases by 2" do
        expect {@test.update_quality()}.to change { @test.items[6].quality }.by(2)
      end

      it "if sellin is between 0-5, Quality increases by 3" do
        expect {@test.update_quality()}.to change { @test.items[7].quality }.by(3)
      end

      it "if sell_in value is below 0 quality drops to 0" do
        expect(@test.items[8].quality).to eq 20
        21.times { @test.update_quality() }
        expect(@test.items[5].quality).to eq 0
      end
    end
      
  end
end
