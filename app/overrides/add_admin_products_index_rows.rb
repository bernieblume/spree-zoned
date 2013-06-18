Deface::Override.new(
  :name             => "add_admin_products_index_rows",
  :virtual_path     => "spree/admin/products/index",
  :insert_after => "[data-hook='admin_products_index_row_actions']",
  :partial          => "spree/admin/zoned/index_rows",
)
