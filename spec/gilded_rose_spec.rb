require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do

  before do
    TEST_ITEMS = [
      Item.new("foo", 0, 0),
      Item.new("Sake", 10, 20),
      Item.new("Normal Item", 1, 10),
      Item.new("Aged Brie", 10, 20),
      Item.new("Sulfuras, Hand of Ragnaros", 0, 50),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    ]
    @test = GildedRose.new(TEST_ITEMS)
  end

  describe "#update_quality" do
    it "does not change the name" do
      expect(@test.update_quality[0].name).to eq "foo"
    end
  end

end
