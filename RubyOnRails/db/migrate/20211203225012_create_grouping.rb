class CreateGrouping < ActiveRecord::Migration[6.1]
  def change
    create_table :groupings do |t|
      t.belongs_to :user
      t.belongs_to :group
      
      t.timestamps
    end
  end
end
