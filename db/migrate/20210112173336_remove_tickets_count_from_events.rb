class RemoveTicketsCountFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :tickets_count, :integer
  end
end
