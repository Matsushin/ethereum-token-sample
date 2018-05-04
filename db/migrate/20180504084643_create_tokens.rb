class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :name
      t.string :symbol
      t.decimal :total_supply
      t.string :token_address

      t.timestamps
    end
  end
end
