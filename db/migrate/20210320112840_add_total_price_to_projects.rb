class AddTotalPriceToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :total_price, :integer
  end
end
