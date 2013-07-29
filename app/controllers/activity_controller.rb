class ActivityController < ApplicationController
  respond_to :json, :html

  def activity_data
    if params[:accession_no]
      activities = ItemRelation.where(accession_no: params[:accession_no])
      if activities.empty?
        respond_with Hash["Not Found", "Not Found"]
      else
        type_array = ['Question', 'Discussion', 'Research', 'Translation', 'Transcription', 'Biography', 'Comment']

        # Remove 'Contribution Request' objects since they are not considered 
        # as an activity. 
        activities.delete_if { |a| a.itemable.class == ContributionRequest }
        respond_with collect_numbers(type_array, activities), :callback => params[:callback]
      end
    end
  end

  # For the comments request
  # def comments
  #   if params[:accession_no]
  #     @comments = Comment.joins(:item_relations).where('accession_no = ?', params[:accession_no])
  #     if @comments.empty?
  #       @comments = Comment.all
  #     end
  #   end
  #   respond_with @comments
  # end

  def collect_numbers(types, activities)
    if types.length > 0 and activities.length > 0
      type = types.pop
      num = activities.length
      activities.delete_if { |ir| ir.itemable.class == "#{type}".constantize }
      Hash["#{type}", num - activities.length].merge(collect_numbers(types, activities))
    else
      Hash["end", "end"]
    end
  end
end
