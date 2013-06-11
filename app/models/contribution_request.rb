class ContributionRequest < Contribution
  validate :check_request_exist

  def check_request_exist
    requests = ContributionRequest.where('details = ?', details)
    previous_request = requests.find {|r| r.item_relation.accession_no == item_relation.accession_no}

    unless previous_request.nil?
      errors.add(:details, 'The request on the item is already in the list.')
    end

  end
end
