require 'spec_helper'

describe Tag do
  it { should belong_to :group }
  it { should have_and_belong_to_many :users }
  it { should have_field :name }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:group) }
end
