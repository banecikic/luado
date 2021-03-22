class AddPriceToPhases < ActiveRecord::Migration[5.2]
  def change
    add_column :phases, :price, :integer, default: "0"
  end
end
