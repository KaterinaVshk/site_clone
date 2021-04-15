require 'rails_helper'

RSpec.describe('Articles', type: :request) do
  let(:category1)    { create(:category)                                                }
  let(:category2)    { create(:category, name: 'auto')                                  }
  let!(:article1)    { create(:article, category: category1)                            }
  let!(:article2)    { create(:article, category: category2)                            }
  let!(:admin)       { create(:admin)                                                   }
  let(:admin_params) { { email: admin.email, password: admin.password }                 }
  let!(:user)        { create(:user)                                                    }
  let(:user_params)  {  { email: user.email, password: user.password }                  }
  let(:article2_params) do
    {
      title: article2.title,
      text: article2.text,
      image: Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/dog.jpeg'), 'image/jpeg'),
      category_id: article2.category_id
    }
  end

  describe '#index' do
    it 'receives articles of a certain category' do
      get "/articles/#{Category.find(article1.category_id).name}"
      expect(assigns(:articles)).to(eq(article1))
    end

    it 'recivies all the articles' do
      get '/articles'
      expect(assigns(:articles)).to(eq(Article.all))
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'saves article and redirect to article path' do
        post '/login', params: admin_params
        post '/articles', params: { article: article2_params }
        expect(response).to(
          redirect_to(
            action: :show,
            id: assigns(:article).id
          )
        )
      end

      it 'redirect to root path if not admin' do
        post '/login', params: user_params
        post '/articles', params: { article: article2_params }
        expect(response).to(
          redirect_to(root_path)
        )
      end
    end

    context 'with invalid attributes' do
      it "redirect to 'new' without title and image" do
        post '/login', params: admin_params
        params_article = {
          text: article2.text,
          category_id: article2.category_id
        }
        post '/articles', params: { article: params_article }
        expect(response).to(
          redirect_to(
            action: :new,
            notice: 'Данные заполнены неверно, попробуйте ещё раз'
          )
        )
      end
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'saves article and redirect to article path' do
        post '/login', params: admin_params
        patch "/articles/#{article2.id}", params: { article: { title: 40 } }
        expect(response).to(
          redirect_to(
            action: :show,
            id: assigns(:article).id
          )
        )
      end

      it 'redirect to root path if not admin' do
        post '/login', params: user_params
        patch "/articles/#{article2.id}", params: { article: { title: 40 } }
        expect(response).to(
          redirect_to(
            root_path
          )
        )
      end
    end

    context 'with invalid attributes' do
      it "redirect to 'edit' nonexistent category" do
        post '/login', params: admin_params
        patch "/articles/#{article2.id}", params: { article: { category_id: 300 } }
        expect(response).to(
          redirect_to(
            action: :edit,
            id: article2.id,
            notice: 'Данные заполнены неверно, попробуйте ещё раз'
          )
        )
      end

      it 'don\'t update unpermitted id parameter' do
        post '/login', params: admin_params
        patch "/articles/#{article2.id}", params: { article: { id: 300 } }
        expect(article2.id).to(eq(article2.id))
      end
    end
  end

  describe '#delete' do
    it 'delete article and redirect to root path' do
      post '/login', params: admin_params
      delete "/articles/#{article2.id}"
      expect(response).to(redirect_to(root_path))
    end

    it 'redirect to root path if not admin' do
      post '/login', params: user_params
      delete "/articles/#{article2.id}"
      expect(response).to(redirect_to(root_path))
    end
  end
end
