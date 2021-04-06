require 'rails_helper'

RSpec.describe('Sessions', type: :request) do
  let(:user1) { create(:user) }

  describe '#create' do
    context 'when user not found' do
      it 'redirects to login form with invalid email' do
        post '/login', params: { '/login': { email: ' 00', password: user1.password } }
        expect(response).to(redirect_to('/login'))
      end

      it 'redirects to login form with invalid password' do
        post '/login', params: { '/login': { email: user1.email, password: '00' } }
        expect(response).to(redirect_to('/login'))
      end

      it 'redirects to login form when without parameters' do
        post '/login', params: { '/login': { email: '', password: '' } }
        expect(response).to(redirect_to('/login'))
      end
    end

    context 'when user found' do
      it 'redirect to root path ' do
        post '/login', params:  { '/login': { email: user1.email, password: user1.password } }
        expect(session[:user_id]).not_to(eql(nil))
        expect(response).to(redirect_to(root_path))
      end
    end
  end

  describe '#destroy' do
    context 'when session is reset' do
      it 'resets session' do
        user_params = attributes_for(:user)
        post '/login', params: { '/login': user_params }
        get '/logout'
        expect(session[:user_id]).to(be(nil))
      end

      it 'redirect to login form' do
        user_params = attributes_for(:user)
        post '/login', params: { '/login': user_params }
        get '/logout'
        expect(response).to(redirect_to(login_path))
      end
    end
  end
end
