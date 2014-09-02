class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :title
      t.integer :inh_user_id
      t.json :json
    end
  end
end
