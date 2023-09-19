class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
    t.string :title
    t.text :description
    t.integer :public_year
    t.boolean :recommended, default=false
    t.timestamps
    end
  end
end
