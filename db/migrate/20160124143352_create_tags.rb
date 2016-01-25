class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :subscriber, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
