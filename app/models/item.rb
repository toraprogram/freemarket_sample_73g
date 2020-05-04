class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :comment
  has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :seller, class_name: "User", optional: true
  belongs_to :category
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :seller_id, presence: true
  validates :name, presence: true, length: { in: 1..40 }
  validates :price, presence: true, numericality: { only_integer: true }, inclusion: { in: 300..9999999 }
  validates :category_id, presence: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :delivery_charge, presence: true
  validates :delivery_day, presence: true
  validates :prefecture_id, presence: true
  validates :size, presence: true
  validates :state, presence: true, inclusion: { in: [true, false] }
  validates_associated :images
end
