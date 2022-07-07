class AddPlaceHolderToWelcome < ActiveRecord::Migration[6.1]
  def change
    create_table :welcome do |t|
      t.string :placeholder
    end
  end
end
