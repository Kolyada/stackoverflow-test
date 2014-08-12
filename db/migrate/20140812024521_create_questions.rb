class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions, id:false do |t|
      t.integer :id
      t.string :title
      t.string :link
      t.belongs_to :tag
    end
    execute "ALTER TABLE questions ADD PRIMARY KEY (id);"
  end

  def down
    drop_table :questions
  end
end
