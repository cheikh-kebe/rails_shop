class Item < ApplicationRecord
  validates_presence_of :title, on: :create, message: "Titre de l'article obligatoire"
  validates_presence_of :description, on: :create, message: "Description de l'article obligatoire"
  validates_presence_of :price, on: :create, message: "Prix de l'article obligatoire"

  has_many :carts
  has_many :line_items
end
