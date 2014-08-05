class ContributionRequest < Contribution
  validate :check_request_exist, if: :accession_no

  def check_request_exist
    requests = ContributionRequest.where('details = ?', details)
    previous_request = requests.detect { |r| r.item_relation.accession_no == accession_no }

    unless previous_request.nil?
      errors.add(:details, 'The request on the item is already in the list.')
    end
  end

  def person_id
    if person_url.present?
      url = person_url.gsub(/\.html|\.htm/, '')
      /\d*$/.match(url).to_s
    end
  end

  def title
    return super if accession_no.present?
    person_name
  end

  def thumbnail
    return super if accession_no.present?
    "#{ENV['WWQI_PERSON_THUMBNAIL']}/person_#{person_id}.jpg"
  end

  def wwqi_url
    return super if accession_no.present?
    "#{ENV['WWQI_SITE']}/en/people/#{person_id}.html"
  end
end
