require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:user) { User.create(name: "Hostname", surname: "Hostsurname", city: "Lodz", email: "a@a.a", password: "password", confirmed_at: DateTime.now) }
  let(:event) { user.events.create(
    name: "Dungeon Games",
    description: "We are going to have so much fun playing games!",
    city: "ert",
    address: "erter",
    start_t: DateTime.now + 1,
    end_t: DateTime.now + 2
  ) }
  let(:valid_attributes) {
    {
      name: "Clue",
      description: "The classic detective game! ",
      min_players: 3,
      max_players: 5,
      event_id: event.id
    }
  }
  let(:invalid_attributes) {
    {
      name: "Clue",
      description: "The classic detective game! ",
      min_players: 8,
      max_players: 5,
      event_id: event.id
    }
  }

  describe "GET #new" do
    context "logged in" do
      before do
        sign_in(user)
        get :new, event_id: event.id
      end

      after do
        sign_out(user)
      end

      it "assigns a new game as @game" do
        expect(assigns(:game)).to be_a_new(Game)
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        get :new, event_id: event.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    let(:game) { Game.create!(valid_attributes) }

    context "logged in" do
      before do
        sign_in(user)
        get :edit, params: { event_id: event.id, id: game.id }
      end

      after do
        sign_out(user)
      end

      it "assigns the requested game as @game" do
        expect(assigns(:game)).to eq(game)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        get :edit, params: { event_id: event.id, id: game.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      context "logged in" do
        before do
          sign_in(user)
        end

        after do
          sign_out(user)
        end

        it "creates a new game" do
          expect {
            post :create, params: {event_id: event.id, game: valid_attributes}
          }.to change(Game, :count).by(1)
        end

        it "assigns a newly created game as @game" do
          post :create, params: {event_id: event.id, game: valid_attributes}
          expect(assigns(:game)).to be_a(Game)
          expect(assigns(:game)).to be_persisted
        end

        it "redirects to event show" do
          post :create, params: {event_id: event.id, game: valid_attributes}
          expect(response).to redirect_to(event)
        end
      end

      context "not logged in" do
        it "redirects to login page" do
          post :create, params: {event_id: event.id, game: valid_attributes}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "with missing param and logged in user" do
      before do
        sign_in(user)
        post :create, params: {event_id: event.id, game: invalid_attributes}
      end

      after do
        sign_out(user)
      end

      it "assigns a newly created but unsaved game as @game" do
        expect(assigns(:game)).to be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:game) { Game.create!(valid_attributes) }

    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Clue",
          description: "New description",
          min_players: 3,
          max_players: 8,
          event_id: event.id
        }
      }

      context "logged in" do
        before do
          sign_in(user)
          put :update, params: {event_id: event.id, id: game.to_param, game: new_attributes}
        end

        after do
          sign_out(user)
        end

        it "assigns the requested game as @game" do
          expect(assigns(:game)).to eq(game)
        end

        it "redirects to the event show" do
          expect(response).to redirect_to(event)
        end
      end

      context "not logged in" do
        it "doesn't update the requested game" do
          put :update, params: {event_id: event.id, id: game.to_param, game: valid_attributes}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "with missing param and logged in user"  do
      before do
        sign_in(user)
        put :update, params: {event_id: event.id, id: game.to_param, game: invalid_attributes}
      end

      after do
        sign_out(user)
      end

      it "assigns the game as @game" do
        expect(assigns(:game)).to eq(game)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    context "logged in" do
      before do
        sign_in(user)
      end

      after do
        sign_out(user)
      end

      it "destroys the requested game" do
        game = Game.create!(valid_attributes)
        expect {
          delete :destroy, params: {event_id: event.id, id: game.to_param}
        }.to change(Game, :count).by(-1)
      end

      it "redirects to the event show" do
        game = Game.create!(valid_attributes)
        delete :destroy, params: {event_id: event.id, id: game.to_param}
        expect(response).to redirect_to(event)
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        game = Game.create!(valid_attributes)
        delete :destroy, params: {event_id: event.id, id: game.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
