module Spree::Zoned
  class Product < ActiveRecord::Base
    attr_accessible :orderno
    belongs_to :spree_country, class_name: ::Spree::Country
    belongs_to :spre_product, class_name: ::Spree::Product
  end
end
