class CreatePhases < ActiveRecord::Migration[5.2]
  def change
    create_table :phases do |t|
      t.string :phase_title
      t.text :content
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
