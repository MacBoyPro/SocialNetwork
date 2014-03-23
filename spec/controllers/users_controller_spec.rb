require 'spec_helper'

describe UsersController do


  describe "GET INDEX" do

    describe "Signed in user" do
      let(:signed_in_user) { FactoryGirl.create(:user) }

      before do
        sign_in :user, signed_in_user
        get :index
      end

      it "assigns @users" do
        users = User.all.to_a
        expect(assigns(:users)).to eq(users)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end #Signed in user

    describe "Signed out user" do

      before do
        get :index
      end

      it "returns forbidden response" do
        expect(response.status).to eq(302)
      end
    end #Signed out user
  end #GET INDEX

  describe "GET SHOW" do

    describe "Signed in user" do
      let(:signed_in_user) { FactoryGirl.create(:user) }
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in :user, signed_in_user
        get :show, id: user.id
      end

      it "assigns @user" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders the show template" do
        expect(response).to render_template("show")
      end
    end #Signed in user

    describe "Signed out user" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        get :show, id: user.id
      end

      it "returns forbidden response" do
        expect(response.status).to eq(302)
      end
    end #Signed out user
  end #GET SHOW
end