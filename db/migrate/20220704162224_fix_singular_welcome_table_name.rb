class FixSingularWelcomeTableName < ActiveRecord::Migration[6.1]
  def change
    rename_table :welcome, :welcomes
  end
end
