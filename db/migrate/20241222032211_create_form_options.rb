class CreateFormOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :form_options do |t|
      t.string :name
      t.string :value
      t.string :category

      t.timestamps
    end
  end
end
