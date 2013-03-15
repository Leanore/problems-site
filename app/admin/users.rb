ActiveAdmin.register User do
   index do
     column :id
     column :login
     column :email
     column :rating
     column :profile
     column :created_at
     column :confirmation_sent_at
     column :confirmed_at
     column :sign_in_count
     column :reset_password_sent_at
     column :last_sign_in_at
     default_actions
   end
end
