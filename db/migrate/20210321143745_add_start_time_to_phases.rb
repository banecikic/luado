class AddStartTimeToPhases < ActiveRecord::Migration[5.2]
  def change
    add_column :phases, :start_time, :datetime
  end
end
