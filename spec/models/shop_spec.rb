require 'spec_helper'

describe Shop do
  it { should have_one(:owner).of_type(User) }
  it { should have_many(:baristas).of_type(User).as_inverse_of(:barista_shop) }
  it { should have_many(:patrons).of_type(User).as_inverse_of(:patron_shop) }
end
