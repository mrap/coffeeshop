require 'spec_helper'

describe Group do
  it { should have_field :name }
  it { should have_many(:members).of_type(User) }
  it { should have_many :tags }
  it { should validate_presence_of :name }
  it { should validate_presence_of :name }

  subject(:group) { create(:group) }

  describe "members" do
    let(:user) { create(:user) }
    it "can add members" do
      group.add_member(user)
      group.members.should include user
    end
    it "can remove members" do
      group.add_member(user)
      expect{ group.remove_member(user) }.to change{ group.members.count }.by(-1)
    end
  end
end
