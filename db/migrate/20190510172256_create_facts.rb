class CreateFacts < ActiveRecord::Migration[5.2]
  def change
    create_table :facts do |t|
      t.string :topic
      t.string :information
      t.integer :contact_id
    end
  end
end
