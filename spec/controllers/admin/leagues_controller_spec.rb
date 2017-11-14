require "rails_helper"

RSpec.describe Admin::LeaguesController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:admin) {FactoryBot.create :user, role: "admin", email: "admintest@gmail.com"}
  let(:continent) {FactoryBot.create :continent}
  let(:country) {FactoryBot.create :country, continent: continent}
  let!(:league) {FactoryBot.create :league, continent: continent, country: country}

  describe "Redirect to root_path if user not admin" do
    before do
      sign_in user
    end
    describe "GET index" do
      before do
        get :index
      end
      it{expect(response).to redirect_to(root_path)}
    end
    describe "GET home_admin" do
      before do
        get :home_admin
      end
      it{expect(response).to redirect_to(root_path)}
    end
    describe "GET edit" do
      before do
        get :edit, params: {id: league}
      end
      it{expect(response).to redirect_to(root_path)}
    end
    describe "PATCH update" do
      before do
        patch :update, params: {id: league, league:
          {name: "UEFA Champions League",
           introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
           continent_id: continent.id, time: DateTime.now, country_id: country.id}}
      end
      it{expect(response).to redirect_to(root_path)}
    end
    describe "GET new" do
      before do
        get :new
      end
      it{expect(response).to redirect_to(root_path)}
    end
    describe "POST create" do
      before do
        post :create, params: {league:
          {name: "UEFA Champions League",
           introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
           continent_id: continent.id, time: DateTime.now, country_id: country.id}}
      end
      it{expect(response).to redirect_to(root_path)}
    end
  end

  describe "User is Admin" do
    before do
      sign_in admin
    end
    describe "GET index" do
      context "When params [:page] and [:quey] is null" do
        before do
          get :index
        end
        it{expect(response).to be_success}
        it{expect(response).to render_template(:index)}
        it{expect(assigns(:leagues)).to eq [league]}
      end
      context "When params[:page] is present" do
        before do
          get :index, params: {page: 1}
        end
        it{expect(response).to be_success}
        it{expect(response).to render_template(:index)}
        it{expect(assigns(:leagues)).to eq [league]}
      end
    end
    describe "GET home_admin" do
      before do
        get :home_admin
      end
      it{expect(response).to be_success}
      it{expect(response).to render_template(:home_admin)}
    end
    describe "GET edit" do
      context "When find league" do
        before do
          get :edit, params: {id: league}
        end
        it{expect(response).to be_success}
        it{expect(response).to render_template(:edit)}
        it{expect(assigns :league).to eq league}
      end
      context "When not found league" do
        before do
          get :edit, params: {id: -1}
        end
        it{expect(response).to redirect_to(admin_leagues_path)}
        it{expect(flash[:danger]).to eq "Not found this league"}
      end
    end
    describe "PATCH update" do
      context "When data invalid" do
        context "Update when name is blank" do
          before do
            patch :update, params: {id: league, league: {name: nil,
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: country.id}}
          end
          it{expect(response).to render_template(:edit)}
          it{expect(flash[:danger]).to eq("Update fail")}
        end
        context "Update when name is to length" do
          before do
            patch :update, params: {id: league, league: {name: "Name of league" * 10,
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: country.id}}
          end
          it{expect(response).to render_template(:edit)}
          it{expect(flash[:danger]).to eq("Update fail")}
        end
        context "Update when continent_id nil" do
          before do
            patch :update, params: {id: league, league: {name: "Name of league",
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: nil, time: DateTime.now, country_id: country.id}}
          end
          it{expect(response).to render_template(:edit)}
          it{expect(flash[:danger]).to eq("Update fail")}
        end
        context "Update when country_id is nil" do
          before do
            patch :update, params: {id: league, league: {name: "Name of league",
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: nil}}
          end
          it{expect(response).to render_template(:edit)}
          it{expect(flash[:danger]).to eq("Update fail")}
        end
        context "Update when time is blank" do
          before do
            patch :update, params: {id: league, league: {name: "Name of league",
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, country_id: country.id, time: nil}}
          end
          it{expect(response).to render_template(:edit)}
          it{expect(flash[:danger]).to eq("Update fail")}
        end
      end
      context "When data valid" do
        before do
          patch :update, params: {id: league, league: {name: "Name of league",
            introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
            continent_id: continent.id, time: DateTime.now, country_id: country.id}}
        end
        it{expect(response).to redirect_to(admin_leagues_path)}
        it{expect(flash[:success]).to eq("Update successfuly")}
      end
    end
    describe "GET new" do
      before do
        get :new
      end
      it{expect(response).to render_template(:new)}
    end
    describe "POST create" do
      context "When data invalid" do
        context "Create when name is blank" do
          before do
            post :create, params: {id: league, league: {name: nil,
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: country.id}}
          end
          it{expect(response).to render_template(:new)}
          it{expect(flash[:danger]).to eq("Create fail")}
          it{expect{post :create, params: {id: league, league: {name: nil,
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: country.id}}}.to_not change(League, :count)}
        end
        context "Create when name is too length" do
          before do
            post :create, params: {id: league, league: {name: "Name of league" * 10,
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: country.id}}
          end
          it{expect(response).to render_template(:new)}
          it{expect(flash[:danger]).to eq("Create fail")}
          it{expect{post :create, params: {id: league, league: {name: "Name of league" * 11,
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: country.id}}}.to_not change(League, :count)}
        end
        context "Create when continent_id is nil" do
          before do
            post :create, params: {id: league, league: {name: "Name of league",
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: nil, time: DateTime.now, country_id: country.id}}
          end
          it{expect(response).to render_template(:new)}
          it{expect(flash[:danger]).to eq("Create fail")}
          it{expect{response}.to_not change(League, :count)}
        end
        context "Create when country_id is nil" do
          before do
            post :create, params: {id: league, league: {name: "Name of league",
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: DateTime.now, country_id: nil}}
          end
          it{expect(response).to render_template(:new)}
          it{expect(flash[:danger]).to eq("Create fail")}
          it{expect{post :create, params: {id: league, league: {name: "Name of league" * 2,
            introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
            continent_id: continent.id, time: DateTime.now, country_id: nil}}}.to_not change(League, :count)}
        end
        context "Create when time is nil" do
          before do
            post :create, params: {id: league, league: {name: "Name of league",
              introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
              continent_id: continent.id, time: nil, country_id: country.id}}
          end
          it{expect(response).to render_template(:new)}
          it{expect(flash[:danger]).to eq("Create fail")}
          it{expect{post :create, params: {id: league, league: {name: "Name of league" * 2,
            introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
            continent_id: continent.id, time: nil, country_id: country.id}}}.to_not change(League, :count)}
        end
      end
      context "When data valid" do
        before do
          post :create, params: {id: league, league: {name: "Name of league",
            introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
            continent_id: continent.id, time: DateTime.now, country_id: country.id}}
        end
        it{expect(response).to redirect_to(admin_leagues_path)}
        it{expect(flash[:success]).to eq("Create successfuly")}
        it{expect{post :create, params: {id: league, league: {name: "Name of league A",
            introduction: "Bayern München, Manchester City and Tottenham Hotspur are through",
            continent_id: continent.id, time: DateTime.now, country_id: country.id}}}.to change(League, :count).by 1}
      end
    end
    describe "DELETE destroy" do
      context "When not found league" do
        before do
          delete :destroy, params: {id: -1}
        end
        it{expect(flash[:danger]).to eq("Not found this league")}
        it{expect(response).to redirect_to(admin_leagues_path)}
        it{expect{delete :destroy, params: {id: -1}}.to_not change(League, :count)}
      end
      context "When find league" do
        it{expect{delete :destroy, params: {id: league}}.to change(League, :count)}
      end
    end
  end
end
