require "spree/zoned/search/base"

if ActiveRecord::Base.connection.tables.include? "spree_countries"

  COMMON_COUNTRIES = ['United States', 'Germany', 'Austria', 'Switzerland', 'Netherlands', 'Belgium', 'Luxembourg']

  COMMON_COUNTRIES_MAPPING = Spree::Country.where(name: COMMON_COUNTRIES).reduce({}) do |h, country|
    h[country.name] = country.id
    h
  end

  COMMON_LOCALES =
    {
    'United States' => [:en], # United States
    'Germany'  => [:de, :en], # Germany
    'Austria'  => [:de, :en], # Austria
    'Switzerland' => [:de, :en], # Switzerland
    'Netherlands' => [:nl, :en], # Netherlands
    'Belgium'  => [:nl, :de, :en], # Belgium
    'Luxembourg' => [:de, :en, :nl], # Luxembourg
  }

  #
  # ZONED_COMMON_COUNTRIES is the list of countries that will be separately listed
  # in the beginning of the country select box for easy selection.
  # Edit the list to your liking.
  # Deprecated!!
  # ZONED_COMMON_COUNTRIES =
    # [
    #  214, # United States
    #  74, # Germany
    #  13, # Austria
    #  195, # Switzerland
    #  142, # Netherlands
    #  20, # Belgium
    #  117, # Luxembourg
    # ]

  #
  # ZONED_COMMOM_LOCALES specifies - for each contry contained in ZONED_COMMON_COUNTRIES - a list (array)
  # of locales that are possibile to select for that specific country.
  # For all countries not included in ZONED_COMMON_COUNTRIES, the locale will automatically be set to :en.
  # The first locale listed for each country is considered that countrie's default locale.
  # sample value :
  # {-49=>[:en],
  # -155=>[:de, :en],
  # -111=>[:de, :en],
  # -101=>[:de, :en],
  # -207=>[:nl, :en],
  # -29=>[:nl, :de, :en],
  # -211=>[:de, :en, :nl]}
  h = {}
  COMMON_LOCALES.each do |country, locale|
    h[-COMMON_COUNTRIES_MAPPING[country]] = locale if COMMON_COUNTRIES_MAPPING[country]
  end
  ZONED_COMMON_LOCALES = h

  Rails.configuration.commonCountriesForSelect = COMMON_COUNTRIES.map do |country|
    [country, -COMMON_COUNTRIES_MAPPING[country]] if COMMON_COUNTRIES_MAPPING[country]
  end

  Rails.configuration.availableLanguages = Hash[ZONED_COMMON_LOCALES.map { |c, lgs| [c, lgs.map { |l| [((l==:en ? "English" : (l==:de ? "Deutsch" : "Nederlands"))) ,l]}]}]

  Spree::Config.searcher_class = Spree::Zoned::Search::Base
  Spree::Config.admin_products_per_page = 64
  #Spree::PrintInvoice::Config[:print_invoice_logo_path] = "admin/bg/hau-to-logo-invoice.jpg"
end
