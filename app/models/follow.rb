class Follow < ApplicationRecord
	belongs_to :user
	belongs_to :sender, class_name: "User", foreign_key: :sender_id
end
