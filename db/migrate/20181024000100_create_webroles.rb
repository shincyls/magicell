class CreateWebroles < ActiveRecord::Migration[5.2]
  def change
    create_table :webroles do |t|
      t.string :role
      t.string :description
      t.boolean :vw_director, default: false
      t.boolean :vw_emp, default: false
      t.boolean :vw_hr, default: false
      t.boolean :vw_finance, default: false
      t.boolean :vw_pro_mgr, default: false
      t.boolean :vw_dpt_mgr, default: false
      t.boolean :vw_it, default: false
      t.boolean :vw_market, default: false
      t.boolean :vw_sale, default: false
      t.boolean :vw_support, default: false
      t.boolean :vw_intern, default: false
      t.boolean :vw_subcon, default: false
      t.boolean :wr_director, default: false
      t.boolean :wr_emp, default: false
      t.boolean :wr_hr, default: false
      t.boolean :wr_finance, default: false
      t.boolean :wr_pro_mgr, default: false
      t.boolean :wr_dpt_mgr, default: false
      t.boolean :wr_it, default: false
      t.boolean :wr_market, default: false
      t.boolean :wr_sale, default: false
      t.boolean :wr_support, default: false
      t.boolean :wr_intern, default: false
      t.boolean :wr_subcon, default: false
      t.timestamps
    end
  end
end
