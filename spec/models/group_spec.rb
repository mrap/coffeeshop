require 'spec_helper'

describe Group do
  it { should have_many(:members).of_type(User) }
  it { should have_many :tags }
  it { should have_many :messages }
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
        it "should not be able to double increment :members_count" do
          group.add_member(user)
          expect{group.add_member(user)}.not_to change{ group.members_count }
        end
      end
      context "when removing members" do
        before { group.add_member(user) }
        it "should remove the user from members" do
          group.remove_member(user)
          group.members.should_not include user
        end
        it "should decrement :members_count" do
          expect{ group.remove_member(user) }.to change{ group.members_count }.by(-1)
        end
        it "should not be able to double decrement :members_count" do
          group.remove_member(user)
          expect{ group.remove_member(user) }.not_to change{ group.members_count }
        end
      end

      context "when a user is a member of a group and joins another" do
        let(:new_group) { create(:group) }
        before do
          group.add_member(user)
          new_group.add_member(user)
        end
        it "should update each group's :members_count correctly" do
          group.members_count.should eq 0
          group.members.should_not include user
          new_group.members_count.should eq 1
          new_group.members.should include user
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

    describe "full text search" do
      before do
        @programming_group = create(:group, name: "Programming")
        @other_group = create(:group)
      end
      context "when searching with only a part of the group's name" do
        let!(:results) { Group.full_text_search("pro") }
        it "should return the correct groups" do
          results.first.should eq @programming_group
          results.count.should eq 1
        end
      end
    end

  end
end
