class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
        when "Normal Item"
          normal = Normal.new(item)
          normal.update(item)
        when "Aged Brie" 
          brie = Brie.new(item)
          brie.update(item)
        when "Sulfuras, Hand of Ragnaros"
          sulfuras = Sulfuras.new(item)
          sulfuras.update(item)
        when "Backstage passes to a TAFKAL80ETC concert" 
          backstage = Backstage.new(item)
          backstage.update(item)
      end
    end
  end 
end   


  class Normal
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update(item)
      item.sell_in -= 1
      return if item.quality <= 0
      item.quality -= 1 if item.sell_in <= 0
      item.quality -= 1
    end


  end

  class Brie
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update(item)
      item.sell_in -= 1
      return if item.quality >= 50
      item.quality += 1
      item.quality += 1 if item.sell_in < 0
    end
  end

  class Sulfuras
    attr_reader :item

    def initialize(item)
      @item = item
    end
  
    def update(item)
    end

  end  

  class Backstage
    attr_reader :item

    def initialize(item)
      @item = item
    end
    def update(item)
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
