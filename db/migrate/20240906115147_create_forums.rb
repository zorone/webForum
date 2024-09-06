class CreateForums < ActiveRecord::Migration[7.2]
  def change
    create_table :forums do |t|
      t.string :thread
      t.text :content

      t.timestamps
    end
  end
end
