class Review < ApplicationRecord
  validates :rating, inclusion: (0..5)
end
