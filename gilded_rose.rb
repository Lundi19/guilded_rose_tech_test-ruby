class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
        when "Normal Item" then normal_update(item)
        when "Aged Brie" then brie_update(item)
        when "Sulfuras, Hand of Ragnaros" then sulfuras_update(item)
        when "Backstage passes to a TAFKAL80ETC concert" then backstage_update(item)
      end
    end
  end  

  def normal_update(item)
    item.sell_in -= 1
    return if item.quality <= 0
    item.quality -= 1 if item.sell_in <= 0
    item.quality -= 1
  end

  def brie_update(item)
    item.sell_in -= 1
    return if item.quality >= 50

    item.quality += 1
    item.quality += 1 if item.sell_in < 0
  end

  def sulfuras_update(item)
  end

  def backstage_update(item)
    item.sell_in -= 1
    return if item.quality >= 50
    return item.quality = 0 if item.sell_in < 0

    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end


end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
