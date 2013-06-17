Deface::Override.new(
  :name          => "add_country_selectbox",
  :virtual_path  => "spree/shared/_nav_bar",
  :insert_before => "nav#top-nav-bar",
  :partial       => "spree/zoned/countryselect",
)
