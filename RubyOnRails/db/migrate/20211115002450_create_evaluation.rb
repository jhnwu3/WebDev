class CreateEvaluation < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.string :evaluee # name of the evaluee
      t.text :context # comments
      t.integer :rating # score

      t.timestamps
    end
  end
end
