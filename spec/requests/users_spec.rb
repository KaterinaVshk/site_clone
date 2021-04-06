require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user1) { create(:user) } 
  
  describe "#create" do

    context "with valid attributes" do
      it "saves user and redirect to root path" do
        post "/signup", params: { user: attributes_for(:user) }
        expect(response).to(redirect_to(root_path))
      end
    end

    context "with invalid attributes" do
      it "render signup path wint invalid password_confirmation" do  
        user_params = attributes_for(:user)
        user_params[:password_confirmation] = '1'
        post "/signup", params: { user: user_params} 
        expect(response).to have_http_status(:success)
        expect(response).not_to(redirect_to('root_path'))
      end

      it "render signup path wint invalid email" do  
        user1.email = "sewH"
        post "/signup", params: { user: { email: user1.email , password: user1.password, password_confirmation: user1.password_confirmation  } } 
        expect(response).to have_http_status(:success)
        expect(response).not_to(redirect_to('root_path'))
      end
    end
  end

end
