require 'spec_helper'

describe Message do
  it { should belong_to :group }
  it { should belong_to(:author).of_type(User) }
  it { should have_field :content }
  it { should validate_presence_of :group }
  it { should validate_presence_of :author }
  it { should validate_presence_of :content }
end
