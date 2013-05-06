require 'spec_helper'

describe 'User Avatar' do
  include ApplicationHelper
  it 'returns a correct gravatar link' do
    avatar_user = build(:user)

    gravatar_id = Digest::MD5::hexdigest(avatar_user.email).downcase

    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"

    avatar_url(avatar_user).should == gravatar_url

  end
end
