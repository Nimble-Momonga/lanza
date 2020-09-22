class Log < ApplicationRecord
  has_one_attached :image

  validates :entry, presence: true
end
