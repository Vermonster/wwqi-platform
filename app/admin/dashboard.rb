ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

      columns do
        column do
          panel "Recent Posts" do
            ul do
              Post.limit(10).map do |post|
                li link_to(post.title, admin_post_path(post))
              end
            end
          end
        end

       column do
         panel "Recent Comments" do
           ul do
             Comment.limit(10).map do |post|
               li link_to(Post.find(post.commentable_id).title, admin_user_comment_path(post))
             end
           end
         end
       end
       
      column do
        panel "Recent Contributions" do
          ul do
            Contribution.limit(10).map do |post|
              li link_to(post.item_id, admin_correction_path(post))
            end
          end
        end
      end
       
    end
     
  end
  
end
