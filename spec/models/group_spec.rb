require 'spec_helper'

describe Group do
  it { should have_many(:members).of_type(User) }
  it { should have_many :tags }
  it { should validate_presence_of :name }
  it { should validate_presence_of :name }
  it { should have_field :name }
  it { should have_field :members_count }

  subject(:group) { create(:group) }

  describe "members" do
    let(:user) { create(:user) }

    describe "adding/removing members" do
      context "when adding members" do
        it "should have user as a member" do
          group.add_member(user)
          group.members.should include user
        end
        it "should increment :member_count" do
          expect{group.add_member(user)}.to change{ group.members_count }.by(1)
        end
      end
      context "when removing members" do
        before { group.add_member(user) }
        it "should remove the user from members" do
          group.remove_member(user)
          group.members.should_not include user
        end
        it "should decrement :member_count" do
          expect{ group.remove_member(user) }.to change{ group.members_count }.by(-1)
        end
      end
    end

    describe "ordering by members" do
      before do
        group_with_3 = create(:group_with_members, members_count: 3)
        group_with_2 = create(:group_with_members, members_count: 2)
        group_with_1 = create(:group_with_members, members_count: 1)
        @expected_order = [group_with_3, group_with_2, group_with_1]
      end
      it ".most_members orders correctly" do
        Group.most_members.to_a.should eq @expected_order
      end
    end
  end
end
