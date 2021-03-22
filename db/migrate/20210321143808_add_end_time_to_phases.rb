class AddEndTimeToPhases < ActiveRecord::Migration[5.2]
  def change
    add_column :phases, :end_time, :datetime
  end
end
