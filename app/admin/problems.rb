ActiveAdmin.register Problem do
  index do
    column :id
    column :user_id
    column :title
    column :description
    column :solved_times
    column :created_at
    column :updated_at
    default_actions
  end

end
