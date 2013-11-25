class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, uniqueness: true, null: false
      t.string :encrypted_password, uniqueness: true, null: false
      t.string :nickname, uniqueness: true, null: false
      t.string :gender
      t.string :contact
      t.string :school
      t.string :major
      t.string :speciality
      t.string :experence
      t.string :avatar
      t.string :auth_token
      t.timestamp :last_auth_time
      t.timestamp :last_login_time

      t.timestamps
    end
  end
end
