class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :group_id
      t.integer :member_id
      t.integer :value

      t.timestamps
    end
  end
end
