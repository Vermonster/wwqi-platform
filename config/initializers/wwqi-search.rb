if !Rails.env.test?
  SEARCH_URL = ENV['SEARCH_URL']
  SEARCH_INDEX = ENV['SEARCH_INDEX']
  SEARCH_ENDPOINT = SEARCH_URL+'/'+SEARCH_INDEX
end

AJAX_STUB_MODE = ENV['LIVE_SEARCH'] ? ENV['LIVE_SEARCH'].inquiry.false? : !Rails.env.production?
