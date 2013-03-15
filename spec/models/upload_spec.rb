require 'spec_helper'

describe Upload do
  it { should belong_to(:uploadable) }
end
