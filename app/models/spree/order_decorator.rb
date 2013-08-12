module Spree
  Order.class_eval do

    attr_accessor :accept
    attr_accessible :accept

    validates :accept, :presence => true, :if => :bill_address_id_updated

    def bill_address_id_updated
      changed.include? "bill_address_id"
    end

  end
end
