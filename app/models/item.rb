class Item < ApplicationRecord
  #Associations
  belongs_to :todo
  #Validations
  validates_presence_of :name
end
