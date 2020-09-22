class Sheet < ApplicationRecord
  belongs_to :phenotype, optional: true
  belongs_to :cultivation, optional: true
  has_and_belongs_to_many :techniques
  has_one :germination
  has_one :vegetative
  has_one :flowering

  accepts_nested_attributes_for :germination, allow_destroy: true
  accepts_nested_attributes_for :vegetative, allow_destroy: true
  accepts_nested_attributes_for :flowering, allow_destroy: true

  validates :name, presence: true
end
