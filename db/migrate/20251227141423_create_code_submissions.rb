class CreateCodeSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :code_submissions do |t|
      t.text :content
      t.string :language
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
