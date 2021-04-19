require 'rails_helper'

RSpec.describe('Users', type: :request) do
  let!(:user1) { create(:user) }
  let!(:admin)       { create(:admin)                                   }
  let(:admin_params) { { email: admin.email, password: admin.password } }
  let(:user_params)  {  { email: user1.email, password: user1.password }  }


  describe '#index' do
    it 'receives all users when admin' do
      post '/login', params: admin_params
      get '/users'
      expect(assigns(:users)).to(eq(User.all))
    end

    it 'redirect to login path if not admin' do
      post '/login', params: user_params
      get '/users'
      expect(response).to(
        redirect_to(
          root_path
        )
      )
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'saves user and redirect to root path' do
        post '/signup', params: { user: attributes_for(:user) }
        expect(response).to(redirect_to(root_path))
      end
    end

    context 'with invalid attributes' do
      it 'render signup path wint invalid password_confirmation' do
        user_params = attributes_for(:user)
        user_params[:password_confirmation] = '1'
        post '/signup', params: { user: user_params }
        expect(response).to(have_http_status(:success))
        expect(response).not_to(redirect_to('root_path'))
      end

      it 'render signup path wint invalid email' do
        user1.email = 'sewH'
        post '/signup',
             params: {
               user: {
                 email: user1.email,
                 password: user1.password,
                 password_confirmation: user1.password_confirmation
               }
             }
        expect(response).to(have_http_status(:success))
        expect(response).not_to(redirect_to('root_path'))
      end
    end
  end

  describe '#make_admin' do
    context 'when admin' do
      it 'updates user and redirect to index path' do
        post '/login', params: admin_params
        put "/make_admin/#{user1.id}"
        expect(User.find(user1.id).type).to(eql('Admin'))
        expect(response).to(
          redirect_to(
            action: :index
          )
        )
      end
    end

    context 'when not admin' do
      it 'redirect to root path ' do
        post '/login', params: user_params
        put "/make_admin/#{user1.id}"
        expect(response).to(
          redirect_to(
            root_path
          )
        )
      end
     end
  end

  describe '#cancel_admin_rights' do
    context 'when admin' do
      it 'cancel admin rights and redirect to index path' do
        post '/login', params: admin_params
        put "/cancel_admin/#{user1.id}"
        expect(User.find(user1.id).type).to(eql('User'))
        expect(response).to(
          redirect_to(
            action: :index
          )
        )
      end
    end

    context 'when not admin' do
      it 'redirect to root path ' do
        post '/login', params: user_params
        put "/cancel_admin/#{user1.id}"
        expect(response).to(
          redirect_to(
            root_path
          )
        )
      end
     end
  end

end
