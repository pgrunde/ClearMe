class CreateInhouseUsers < ActiveRecord::Migration
  def change
    create_table :inhouse_users do |t|
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
