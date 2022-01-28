class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :projectname
      t.string :projecttype
      t.string :date
      t.integer :assigned # reminder this variable is a variable that represents "whether or not evaluations have been assigned"

      t.timestamps
    end
  end
end
