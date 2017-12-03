class Post < ApplicationRecord
    belongs_to :author
    validates_presence_of :content
end
