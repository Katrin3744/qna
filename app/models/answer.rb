class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, foreign_key: "author_id", class_name: "User"

  validates :body, presence: true
end
