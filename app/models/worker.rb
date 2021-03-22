class Worker < ApplicationRecord
  validates :name, :service, :price, :worker_type, presence: true

  WORKER_TYPES = [:Moler, :Keramicar, :Zidar, :Assembler]
  def self.worker_types
    WORKER_TYPES.map { |worker_type| [worker_type, worker_type] }
  end
end
