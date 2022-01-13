class Purchase < ApplicationRecord
  belongs_to :purchaser_id
  belongs_to :item_id
end
