class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|

      t.timestamps null: false
    end
  end
end
