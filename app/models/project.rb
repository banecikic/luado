class Project < ApplicationRecord
  validates :title, :total_price,  presence: true
  validates :description, presence: true, length: { :minimum => 5 }

  belongs_to :user
  has_many :phases, dependent: :destroy
  def to_s
    title
  end
end
