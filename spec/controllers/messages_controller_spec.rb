require 'rails_helper'

describe MessagesController, type: :controller do

  describe 'GET #index' do
    it "populates an array of messages" do
      messages = create_list(:message, 3)
      get :index
      expect(assigns(:messages)).to match(messages)
    end

    it "renders the :index template" do
      get :index
    end

  end

  describe 'POST #create' do
    it "saves the new contact in the database" do
      expect{
        post :create, message: attributes_for(:message)
      }.to change(Message, :count).by(1)
    end

    it "redirects to messages#index" do
      post :create, message: attributes_for(:message)
      expect(response).to redirect_to root_path
    end

  end

end

