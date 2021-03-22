class AddPhaseTypeeToPhases < ActiveRecord::Migration[5.2]
  def change
    add_column :phases, :phase_type, :string
  end
end
