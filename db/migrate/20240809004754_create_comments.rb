class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.integer :commenter_id
      t.integer :location_id
      t.text :content

      t.timestamps
    end
  end
end
