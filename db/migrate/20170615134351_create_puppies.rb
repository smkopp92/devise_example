class CreatePuppies < ActiveRecord::Migration[5.0]
  def change
    create_table :puppies do |t|
      t.string :name, null: false
      t.string :img_url, null: false
    end
  end
end
