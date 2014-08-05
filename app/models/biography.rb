class Biography < Contribution
  validates :person_name, presence: true

  validates :person_url,
    allow_blank: true,
    format: { with: /people\/\d+\.html/, message: 'must be valid person URL' }

  def person_id
    url = person_url.gsub(/\.html|\.htm/, '')
    /\d*$/.match(url).to_s
  end

  def title
    person_name
  end

  def thumbnail
    "#{ENV['WWQI_PERSON_THUMBNAIL']}/person_#{person_id}.jpg"
  end

  def wwqi_url
    "#{ENV['WWQI_SITE']}/en/people/#{person_id}.html"
  end
end
