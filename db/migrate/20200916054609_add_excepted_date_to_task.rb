class AddExceptedDateToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :excepted_datetime, :timestamp
  end
end
