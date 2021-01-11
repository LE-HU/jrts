class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :event_time
      t.integer :guest_limit
      t.integer :tickets_count
      t.integer :ticket_price

      t.timestamps
    end
  end
end
