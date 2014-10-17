class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :bio
      t.integer :cv_id
    end
  end
end
