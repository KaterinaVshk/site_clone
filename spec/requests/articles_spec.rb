require 'rails_helper'

RSpec.describe('Articles', type: :request) do
  before(:all) do
    @article1 = create(:article)
    @article2 = create(:article)
  end

  describe '#index' do
    it 'receives news of a certain category' do
      get "/news/#{Category.find(@article1.category_id).name}"
      expect(assigns(:articles)).to(eq(@article1))
    end

    it 'recivies all the news' do
      get '/news'
      expect(assigns(:articles)).to(eq(Article.all))
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'saves article and redirect to article path' do
        params_article = {
          title: @article2.title,
          text: @article2.text,
          image: Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/dog.jpeg'), 'image/jpeg'),
          category_id: @article2.category_id
        }
        post '/news', params: { article: params_article }
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
          text: @article2.text,
          category_id: @article2.category_id
        }
        post '/news', params: { article: params_article }
        expect(response).to(have_http_status(:success))
        expect(response).not_to(redirect_to(action: :show))
      end
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'saves article and redirect to article path' do
        patch "/news/#{@article2.id}", params: { article: { title: 40 } }
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
        patch "/news/#{@article2.id}", params: { article: { category_id: 300 } }
        expect(response).to(
          redirect_to(
            action: :edit,
            id: @article2.id
          )
        )
      end

      it 'don\'t update unpermitted id parameter' do
        patch "/news/#{@article2.id}", params: { article: { id: 300 } }
        expect(@article2.id).to(eq(3))
      end
    end
  end

  describe '#delete' do
    it 'delete article and redirect to root path' do
      delete "/news/#{@article2.id}"
      expect(response).to(redirect_to(root_path))
    end
  end
end
