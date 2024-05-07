class Message < ApplicationRecord
	has_one_attached :message_image
	belongs_to :room
end
