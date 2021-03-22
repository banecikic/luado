class AddWorkerTypeToWorker < ActiveRecord::Migration[5.2]
  def change
    add_column :workers, :worker_type, :string
  end
end
