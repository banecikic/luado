class AddWorkerTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :worker_type, :string
  end
end
