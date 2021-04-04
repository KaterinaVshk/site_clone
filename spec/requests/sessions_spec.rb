require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  let(:user1) { create(:user) } 

  describe "#create" do

    context "user not found" do

      it "with invalid email" do
        post "/login" , params: { '/login': {email:' 00' , password: user1.password }} 
        expect(response).to(redirect_to('/login'))
      end

      it "with invalid password" do
        post "/login" , params: { '/login': { email: user1.email , password: '00' } }
        expect(response).to(redirect_to('/login'))
      end

      it "without parameters" do
        post "/login" ,  params: { '/login': { email: "" , password: "" } }
        expect(response).to(redirect_to('/login'))
      end
    end

    context "user found" do
      it "redirect to root path " do  
        post "/login", params:  { '/login': {  email: user1.email , password: user1.password  }} 
        expect(session[:user_id]).not_to(eql(nil))
        expect(response).to(redirect_to(root_path))
      end
    end
  end

  describe "#destroy" do

    it "session is reset" do
      user_params = attributes_for(:user)
      post "/login", params:  { '/login': user_params }
      get "/logout" 
      expect(session[:user_id]).to(eql(nil))
    end

  end

end

