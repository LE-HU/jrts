class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :paid, null: false, default: false

      t.timestamps
    end
  end
end
