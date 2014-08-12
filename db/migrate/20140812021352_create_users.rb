class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, id:false do |t|
      t.integer :account_id
      t.string :nickname
      t.string :profile_image
      t.string :link
    end
    add_index :users, :nickname
    execute "ALTER TABLE users ADD PRIMARY KEY (account_id);"
  end

  def down
    drop_table :users
  end
end
