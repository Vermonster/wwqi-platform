def fill_in_required_post_fields
  fill_in 'post_tag_list', with: 'a tag'
  fill_in 'post_title', with: 'a title'
  fill_in 'post_details', with: 'additional details'
end
