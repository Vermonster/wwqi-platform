ActiveAdmin.register User do

  decorate_with UserDecorator
  
  menu :priority => 2

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :created_at             
    default_actions                   
  end                                 
  
  filter :first_name
  filter :last_name
  filter :email 
  
end
