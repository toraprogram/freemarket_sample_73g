class Address < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  validates :postal_code, presence: true
  validates :prefecture_id, numericality: true, presence: true, inclusion:{in:1..47}
  validates :city, presence: true
  validates :block, presence: true
end
