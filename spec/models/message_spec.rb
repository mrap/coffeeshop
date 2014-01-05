require 'spec_helper'

describe Message do
  it { should belong_to(:author).of_type(User) }
  it { should have_field :content }
  it { should have_field :created_at }
  it { should validate_presence_of :author }
  it { should validate_presence_of :content }

  describe "scopes by most recent" do
    before do
      @oldest_message = create(:message, created_at: DateTime.now.advance(days: -1))
      @newest_message = create(:message)
    end
    it "returns the newest first" do
      Message.all.first.should eq @newest_message
      Message.all.last.should eq @oldest_message
    end
  end
end

