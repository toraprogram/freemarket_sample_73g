class Item < ApplicationRecord

  has_many :comment
  has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
  belongs_to :category
  belongs_to :brand
  accepts_nested_attributes_for :images, allow_destroy: true

end
