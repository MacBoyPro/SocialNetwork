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

      it "redirects to sign in" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_url)
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

      it "redirects to sign in" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_url)
      end
    end #Signed out user
  end #GET SHOW

  describe "GET EDIT" do
    describe "Signed in user" do
      context "user is trying to edit themselves" do
        let(:signed_in_user) { FactoryGirl.create(:user) }

        before do
          sign_in :user, signed_in_user
          get :edit, id: signed_in_user.id
        end

        it "responds with success" do
          expect(response).to be_success
        end

        it "assigns @user" do
          expect(assigns(:user)).to eq(signed_in_user)
        end

        it "renders the edit template" do
          expect(response).to render_template("edit")
        end
      end #user is trying to edit themselves

      context "user is trying to edit another user" do
        let(:signed_in_user) { FactoryGirl.create(:user) }
        let(:another_user) { FactoryGirl.create(:user) }

        before do
          sign_in :user, signed_in_user
          get :edit, id: another_user.id
        end

        it "responds with forbidden" do
          expect(response.code).to eq("403")
        end
      end #user is trying to edit another user
    end #Signed in user

    describe "Signed out user" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        get :edit, id: user.id
      end

      it "redirects to sign in" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_url)
      end
    end #Signed out user
  end #GET EDIT

  describe "PUT UPDATE" do
    describe "Signed in user" do
      context "user is trying to edit themselves" do
        let(:signed_in_user) { FactoryGirl.create(:user) }

        before do
          sign_in :user, signed_in_user
          put :update, id: signed_in_user.id, user: { first_name:"Justin", last_name: "Bieber" }
        end

        it "updates the user" do
          signed_in_user.reload
          expect(signed_in_user.first_name).to eq("Justin")
          expect(signed_in_user.last_name).to eq("Bieber")
        end

        it "redirects to the users show page" do
          expect(response.status).to eq(302)
          expect(response).to redirect_to(user_path(signed_in_user))
        end
      end #user is trying to edit themselves

      context "user is trying to edit another user" do
        let(:signed_in_user) { FactoryGirl.create(:user) }
        let(:another_user) { FactoryGirl.create(:user) }

        before do
          sign_in :user, signed_in_user
          put :update, id: another_user.id, user: { first_name:"Justin", last_name: "Bieber" }
        end

        it "responds with forbidden" do
          expect(response.code).to eq("403")
        end
      end #user is trying to edit another user
    end #Signed in user

    describe "Signed out user" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        put :update, id: user.id, user: { first_name:"Justin", last_name: "Bieber" }
      end

      it "redirects to sign in" do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_url)
      end
    end #Signed out user
  end #PUT UPDATE
end