require 'rails_helper'

RSpec.describe('Articles', type: :request) do
  let(:category1)  { create(:category)                    }
  let(:category2)  { create(:category, name: 'auto')                    }
  let!(:article1) { create(:article, category: category1) }
  let!(:article2) { create(:article, category: category2 ) }

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
        params_article = {
          title: article2.title,
          text: article2.text,
          image: Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/dog.jpeg'), 'image/jpeg'),
          category_id: article2.category_id
        }
        post '/articles', params: { article: params_article }
        expect(response).to(
          redirect_to(
            action: :show,
            id: assigns(:article).id
          )
        )
      end
    end

    context 'with invalid attributes' do
      it "redirect to 'new' without title and image" do
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
        patch "/articles/#{article2.id}", params: { article: { title: 40 } }
        expect(response).to(
          redirect_to(
            action: :show,
            id: assigns(:article).id
          )
        )
      end
    end

    context 'with invalid attributes' do
      it "redirect to 'edit' nonexistent category" do
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
        patch "/articles/#{article2.id}", params: { article: { id: 300 } }
        expect(article2.id).to(eq(article2.id))
      end
    end
  end

  describe '#delete' do
    it 'delete article and redirect to root path' do
      delete "/articles/#{article2.id}"
      expect(response).to(redirect_to(root_path))
    end
  end
end
