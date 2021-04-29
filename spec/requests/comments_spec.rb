require 'rails_helper'

RSpec.describe('Articles', type: :request) do
  let!(:user) { create(:user) }
  let!(:user_params) { { email: user.email, password: user.password } }
  let!(:admin)       { create(:admin) }
  let!(:category)   { create(:category) }
  let!(:article1)    { create(:article, category: category, admin_id: admin.id) }
  let!(:comment) { create(:comment, commentable: article1)}

  
  describe '#create' do
    context 'with valid attributes' do
      it 'saves comments and redirect to comment path' do
        post '/login', params: user_params
        post "/articles/#{article1.id}/comments", params: { comment: { content: "sg", article_id: "#{article1.id}"}  }
        expect(response).to(redirect_to(article_path(article1.id)))
      end

      it 'redirect to root path if not admin' do
        post '/login', params: user_params
        post "/articles/#{article1.id}/comments", params: { comment: { content: "sg" , article_id: "#{article1.id}"} }
        expect(response).to(redirect_to(article_path(article1.id)))
      end
    end
  end
end
