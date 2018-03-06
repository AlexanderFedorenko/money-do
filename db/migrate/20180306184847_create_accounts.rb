class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :kind
      t.string :ancestry
      t.monetize :initial_balance

      t.timestamps
    end
    add_index :accounts, :ancestry
  end
end
