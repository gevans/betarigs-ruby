module Betarigs
  class Rig < Resource

    KILOHASH = 1_000

    attributes :id, :name, :description, :declared_speed, :algorithm, :price,
      :stats, :status

    ##
    # @return [Integer]
    #   Speed of rig in Hashes per second.
    def declared_speed
      read_attribute(:declared_speed)['value'] * KILOHASH
    end

    ##
    # @return [BigDecimal]
    #   Total price in BTC per day.
    def price
      BigDecimal.new(read_attribute(:price)['total']['value'], 8)
    end

    ##
    # @return [BigDecimal]
    #   Unit price in BTC per megahash, per day.
    def unit_price
      BigDecimal.new(read_attribute(:price)['per_speed_unit']['value'], 16)
    end
  end # Rig
end # Betarigs
