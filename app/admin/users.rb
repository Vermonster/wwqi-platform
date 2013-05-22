ActiveAdmin.register User do
  
  menu :priority => 2

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email
    column :is_admin                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :created_at             
    default_actions                   
  end                                 
  
  filter :first_name
  filter :last_name
  filter :is_admin
  filter :email 
  
  form do |f|                         
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email                  
      f.input :password               
      f.input :password_confirmation
      f.input :is_admin  
    end                               
    f.actions                         
  end
end
