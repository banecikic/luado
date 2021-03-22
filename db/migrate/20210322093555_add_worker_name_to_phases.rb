class AddWorkerNameToPhases < ActiveRecord::Migration[5.2]
  def change
    add_column :phases, :worker_name, :string
  end
end
