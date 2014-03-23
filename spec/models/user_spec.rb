require 'spec_helper'

describe User do

  it do
    should have_attribute(:first_name).
      of_type(String)
  end

  it do
    should have_attribute(:last_name).
      of_type(String)
  end

  it do
    should have_attribute(:email).
      of_type(String)
  end

  it do
    should have_attribute(:encrypted_password).
      of_type(String)
  end

  context "password" do
    it "fails all validations with no password" do
      expect(User.new).to have(3).errors_on(:password)
    end

    it "fails validation with no name expecting a specific message" do
      expect(User.new.errors_on(:password)).to include("can't be blank")
    end

    it "fails validation with a short password" do
      user = User.new(password: "short")
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
end
