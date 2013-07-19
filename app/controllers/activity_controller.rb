class ActivityController < ApplicationController
  respond_to :json

  def activity_data
    if params[:accession_no]
      type_array = ['Question', 'Discussion', 'Research', 'Translation', 'Transcription', 'Biography', 'Comment']
      activities = ItemRelation.where(accession_no: params[:accession_no])
      activities.delete_if { |a| a.itemable.class == ContributionRequest }
      respond_with collect_numbers(type_array, activities)
    end
  end

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
