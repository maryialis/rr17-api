class AddAuthorToSourceProvider < ActiveRecord::Migration[5.1]
  def change
    add_column :source_providers, :author, :int
    add_foreign_key :source_providers, :users, column: :author
  end
end
