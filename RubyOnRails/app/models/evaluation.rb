class Evaluation < ApplicationRecord
  # belongs_to :users
  # belongs_to :projects
 
 
 validates :evaluee, presence:true, length:{ maximum:150 }
 validates :context, presence:true, length:{maximum:150}
 validates :rating, numericality: {only_integer: true}
 
end
