class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :event_time, null: false
      t.integer :guest_limit, null: false
      t.integer :tickets_count
      t.integer :ticket_price, null: false

      t.timestamps
    end
  end
end
