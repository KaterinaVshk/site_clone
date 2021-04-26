require 'rails_helper'

RSpec.describe('Articles', type: :request) do
  let!(:category1)   { create(:category)                                                }
  let!(:category2)   { create(:category, name: 'opinions', id: 2)                       }
  let!(:admin)       { create(:admin)                                                   }
  let!(:user)        { create(:user)                                                    }
  let!(:article1)    { create(:article, category: category1, admin_id: admin.id)        }
  let!(:article2)    { create(:article, category: category2, admin_id: admin.id)        }
  let(:admin_params) { { email: admin.email, password: admin.password }                 }
  let!(:user_params) { { email: user.email, password: user.password }                   }
  let!(:article2_params) do
    {
      title: article2.title,
      text: article2.text,
      image: Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/dog.jpeg'), 'image/jpeg'),
      category: category2.name
    }
  end

  describe '#index' do
    it 'receives articles of a certain category' do
      get "/news/#{Category.find(article1.category_id).name}"
      expect(assigns(:articles)[0]).to(eq(article1))
    end

    it 'recivies all the articles' do
      get root_path
      expect(assigns(:articles)[0]).to(eq(Article.all[-1]))
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
          category_id: category2.id
        }
        post '/articles', params: { article: params_article }
        expect(flash[:alert]).to(eq('Данные заполнены неверно, попробуйте ещё раз'))
      end
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'saves article and redirect to article path' do
        post '/login', params: admin_params
        patch "/articles/#{article2.id}", params: { article: { title: 40, category: category1.name } }
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
        patch "/articles/#{article2.id}", params: { article: { category: 'fdgb' } }
        expect(flash[:alert]).to(eq('Данные заполнены неверно, попробуйте ещё раз'))
        expect(response).to(
          redirect_to(
            action: :edit,
            id: article2.id
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
