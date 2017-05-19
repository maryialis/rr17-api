class CreateSourceProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :source_providers do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.string :address, :null => false
      t.timestamp :last_sync_at
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
    add_index :source_providers, :name, unique: true
    add_index :source_providers, :url, unique: true  
  end
end
