class Notification < ApplicationRecord
	default_scope { order(created_at: :desc) }
	belongs_to :user
	belongs_to :created_by, class_name: "User", foreign_key: :current_user_id
end
