class Author < ApplicationRecord
    has_many :posts
    validates_presence_of :device_id
    validates :username, uniqueness: true, presence: true 
end
