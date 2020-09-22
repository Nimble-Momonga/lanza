class Stage < ApplicationRecord
  TYPES = %w[Germination Vegetative Flowering].freeze

  enum type: Hash[TYPES.zip(TYPES)]

  belongs_to :sheet
  has_many :logs, dependent: :destroy

  accepts_nested_attributes_for :logs, allow_destroy: true

  validates :type, presence: true
end
