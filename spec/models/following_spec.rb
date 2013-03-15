require 'spec_helper'

describe Following do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:followable_id) }
  it { should belong_to(:user) }
  it { should belong_to(:followable) }
end
