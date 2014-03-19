require 'spec_helper'

describe User do
  
  it "should require a password" do
    expect(User.new(password: "")).not_to be_valid
  end

end
