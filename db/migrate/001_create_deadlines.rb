class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines, :force => true do |t|
      t.date    :due_date, :null => false
      t.string    :title
      t.text      :notes
      t.string    :state, :null => false, :default => "expected"

      t.timestamps
    end

    create_table :deadlines_users, :id => false, :force => true do |t|
      t.integer   :deadline_id, :null => false
      t.integer   :user_id, :null => false
    end
  end
end
