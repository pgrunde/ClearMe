class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.string :location
      t.integer :form_id
      t.integer :inh_user_id
      t.timestamps
    end
  end
end
