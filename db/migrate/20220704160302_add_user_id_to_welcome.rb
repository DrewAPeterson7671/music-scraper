class AddUserIdToWelcome < ActiveRecord::Migration[6.1]
  def change
    add_reference :welcome, :user, index: true
  end
end
