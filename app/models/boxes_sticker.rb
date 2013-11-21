class BoxesSticker < ActiveRecord::Base
  belongs_to :sticker
  belongs_to :box
end
