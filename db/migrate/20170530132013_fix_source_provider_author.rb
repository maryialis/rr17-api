class FixSourceProviderAuthor < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :source_providers, :author, :user_id
  end

  def self.down
  end
end
