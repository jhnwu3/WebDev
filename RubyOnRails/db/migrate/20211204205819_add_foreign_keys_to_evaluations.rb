class AddForeignKeysToEvaluations < ActiveRecord::Migration[6.1]
  def change
    add_column :evaluations, :senderid, :integer
    add_column :evaluations, :receiverid, :integer
    add_column :evaluations, :pid, :integer
  end
end
