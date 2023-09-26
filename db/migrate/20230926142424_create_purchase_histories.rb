class CreatePurchaseHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount
      t.datetime :purchased_at

      t.timestamps
    end
  end
end