class Phase < ApplicationRecord
  belongs_to :project
  validates :phase_title, :content, :project, :price, :phase_type, presence: true

  scope :phase_type, ->(phase_type) { where("phase_type == ?", phase_type) }


  PHASE_TYPES = [:Painting, :Polishing, :Building, :Tiles_job]
  def self.phase_types
    PHASE_TYPES.map { |phase_type| [phase_type, phase_type] }
  end

end
