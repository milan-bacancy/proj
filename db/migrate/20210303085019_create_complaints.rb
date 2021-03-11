class CreateComplaints < ActiveRecord::Migration[6.0]
  def change
    create_table :complaints do |t|
      t.string :title
      t.string :desc
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
