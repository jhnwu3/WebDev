class Group < ApplicationRecord
    has_many :groupings
    has_many :users, through: :groupings

    has_many :project_groups
    has_many :projects, through: :project_groups
end
