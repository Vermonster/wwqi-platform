require 'spec_helper'

describe AdminUser do
  subject { create(:admin_user) }
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should respond_to(:password) }
  it { should validate_uniqueness_of(:email) }
  
end
