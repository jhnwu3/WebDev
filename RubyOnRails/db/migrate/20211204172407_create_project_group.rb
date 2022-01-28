class CreateProjectGroup < ActiveRecord::Migration[6.1]
  def change
    create_table :project_groups do |t|
      t.belongs_to :project
      t.belongs_to :group

      t.timestamps
    end
  end
end
