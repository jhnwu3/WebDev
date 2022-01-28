class Project < ApplicationRecord
    has_many :project_groups
    has_many :groups, through: :project_groups
    
    
    validates :date, presence: true, length:{minimum: 10},   
        uniqueness: true
end
