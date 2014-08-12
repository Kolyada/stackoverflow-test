class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.datetime :questions_last_update
    end
    add_index :tags, :title, unique: true
  end
end
