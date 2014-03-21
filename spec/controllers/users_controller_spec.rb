require 'spec_helper'

describe UsersController do
  describe "GET SHOW" do

    it "assigns @user" do
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it "renders the index template" do
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to render_template("show")
    end

  end #GET SHOW
end