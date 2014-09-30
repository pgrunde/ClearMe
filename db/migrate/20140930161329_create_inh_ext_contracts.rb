class CreateInhExtContracts < ActiveRecord::Migration
  def change
    create_table :inh_ext_contracts do |t|
      t.integer :ext_user_id
      t.integer :inh_user_id
      t.boolean :ext_accepted
      t.boolean :inh_accepted
      t.timestamps
    end
  end
end
