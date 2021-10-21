class CreateZips < ActiveRecord::Migration[6.0]
  def change
    create_table :zips do |t|
      t.integer :zipcode

      t.timestamps
    end
  end
end
