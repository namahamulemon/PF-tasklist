class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.text :title
      t.text :content

      t.datetime :start_day
      t.datetime :end_day
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end