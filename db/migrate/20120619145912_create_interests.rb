class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.text :description

      t.timestamps
    end
  end
end
