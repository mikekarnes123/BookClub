class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :page_count
      t.string :year_published
      t.string :thumbnail_url
      t.timestamps
    end
  end
end
