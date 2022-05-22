class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: "author_id", class_name: "Question", dependent: :destroy
  has_many :answers, foreign_key: "author_id", class_name: "Answer", dependent: :destroy

  def author_of?(essence)
    essence.author_id == id
  end
end
