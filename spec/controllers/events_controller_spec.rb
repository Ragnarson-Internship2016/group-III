require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { User.create!(name: "Username", surname: "Usersurname", city: "Lodz", email: "a@a.a", password: "password") }

  let(:valid_attributes) {
    {
      name: "Dungeon Games",
      description: "We are going to have so much fun playing games!",
      city: "Lodz",
      address: "Piotrkowska 217",
      start_t: DateTime.parse("09/08/2016 17:00"),
      end_t: DateTime.parse("09/08/2016 22:00"),
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      name: "Dungeon Games",
      description: "We are going to have so much fun playing games!",
      city: "",
      address: "",
      start_t: DateTime.parse("09/08/2016 17:00"),
      end_t: DateTime.parse("09/08/2016 18:00"),
      user_id: user.id
    }
  }

  describe "GET #index" do
    it "assigns all events as @events" do
      event = Event.create!(valid_attributes)
      get :index
      expect(assigns(:events)).to eq([event])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    let(:event) { Event.create!(valid_attributes) }

    before do
      get :show, params: {id: event.to_param}
    end

    it "assigns the requested event as @event" do
      expect(assigns(:event)).to eq(event)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    context "logged in" do
      before do
        sign_in(user)
        get :new
      end

      after do
        sign_out(user)
      end

      it "assigns a new event as @event" do
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    let(:event) { Event.create!(valid_attributes) }

    context "logged in" do
      before do
        sign_in(user)
        get :edit, params: { id: event.to_param }
      end

      after do
        sign_out(user)
      end

      it "assigns the requested event as @event" do
        expect(assigns(:event)).to eq(event)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        get :edit, params: { id: event.to_param }
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

        it "creates a new Event" do
          expect {
            post :create, params: {event: valid_attributes}
          }.to change(Event, :count).by(1)
        end

        it "assigns a newly created event as @event" do
          post :create, params: {event: valid_attributes}
          expect(assigns(:event)).to be_a(Event)
          expect(assigns(:event)).to be_persisted
        end

        it "redirects to the created event" do
          post :create, params: {event: valid_attributes}
          expect(response).to redirect_to(Event.last)
        end
      end

      context "not logged in" do
        it "redirects to login page" do
          post :create, params: {event: valid_attributes}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "with missing param and logged in user" do
      before do
        sign_in(user)
        post :create, params: {event: invalid_attributes}
      end

      after do
        sign_out(user)
      end

      it "assigns a newly created but unsaved event as @event" do
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:event) { Event.create!(valid_attributes) }

    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Ludo",
          description: "We are not going to have so much fun playing games!",
          city: "Lodz",
          address: "Piotrkowska 217",
          start_t: DateTime.parse("09/08/2016 17:00"),
          end_t: DateTime.parse("09/08/2016 18:00"),
          user_id: user.id
        }
      }

      context "logged in" do
        before do
          sign_in(user)
          put :update, params: {id: event.to_param, event: new_attributes}
        end

        after do
          sign_out(user)
        end

        it "assigns the requested event as @event" do
          expect(assigns(:event)).to eq(event)
        end

        it "redirects to the event" do
          expect(response).to redirect_to(event)
        end
      end

      context "not logged in" do
        it "doesn't update the requested event" do
          put :update, params: {id: event.to_param, event: valid_attributes}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "with missing param and logged in user"  do
      before do
        sign_in(user)
        put :update, params: {id: event.to_param, event: invalid_attributes}
      end

      after do
        sign_out(user)
      end

      it "assigns the event as @event" do
        expect(assigns(:event)).to eq(event)
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

      it "destroys the requested event" do
        event = Event.create!(valid_attributes)
        expect {
          delete :destroy, params: {id: event.to_param}
        }.to change(Event, :count).by(-1)
      end

      it "redirects to the events list" do
        event = Event.create!(valid_attributes)
        delete :destroy, params: {id: event.to_param}
        expect(response).to redirect_to(events_url)
      end
    end

    context "not logged in" do
      it "redirects to login page" do
        event = Event.create!(valid_attributes)
        delete :destroy, params: {id: event.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
