class CreateForeignKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :user_group, id: false do |t|
      t.belongs_to :user
      t.belongs_to :group
    end

    create_table :project_group, id: false do |t|
      t.belongs_to :project 
      t.belongs_to :group
    end

    # add_column :user_id, :evaluations, :integer
    # add_column :project_id, :evaluations, :integer

    # add_foreign_key :evaluations, :users
    # add_foreign_key :evaluations, :projects
  end
end
