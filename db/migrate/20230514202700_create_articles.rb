class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :slug, null: false, index: { unique: true }
      t.string :title
      t.string :description
      t.text :body

      t.timestamps
    end
  end
end
