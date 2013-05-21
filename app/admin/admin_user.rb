ActiveAdmin.register AdminUser do  

  menu :priority => 2
   
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
