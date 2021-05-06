require 'rails_helper'

RSpec.describe('Preferences', type: :request) do
  let!(:user)        { create(:user)                                                    }
  let!(:user_params) { { email: user.email, password: user.password }                   }
  let!(:admin)       { create(:admin)                                                   }
  let!(:category)    { create(:category)                                                }
  let!(:article1)    { create(:article, category: category, admin_id: admin.id)         }
  let!(:comment)     { create(:comment, commentable: article1, article_id: article1.id) }

  describe '#create' do
    context 'when like not exists' do
      it 'create like, change comment and redirect to article path' do
        post '/login', params: user_params
        post '/preferences', params: { comment_id: comment.id, user_id: user.id, type: 'Like', article_id: comment.article_id }
        expect(Comment.all.last.likes.size).to(eq(1))
        expect(Like.all.count).to(eq(1))
        expect(response).to(redirect_to(article_path(comment.article_id)))
      end

      it 'redirect to login path if not user' do
        post '/preferences', params: { comment_id: comment.id, user_id: user.id, type: 'Like', article_id: comment.article_id }
        expect(response).to(redirect_to(login_path))
      end
    end

    context 'when like exists' do
      let!(:comment2) { create(:comment, commentable: article1, article_id: article1.id) }
      let!(:like)     { create(:preference, comment_id: comment2.id, user_id: admin.id, type: 'Like')                        }
      let!(:dislike)  { create(:preference, comment_id: comment2.id, user_id: user.id, type: 'Dislike')                      }

      it 'remove like, change comment and redirect to article path' do
        post '/login', params: user_params
        post '/preferences', params: { comment_id: comment2.id, user_id: admin.id, type: 'Like', article_id: comment2.article_id }
        expect(Comment.all.last.likes.size).to(eq(0))
        expect(Like.all.count).to(eq(0))
        expect(response).to(redirect_to(article_path(comment.article_id)))
      end

      it 'remove dislike, create like, change comment and redirect to article path' do
        post '/login', params: user_params
        post '/preferences', params: { comment_id: comment2.id, user_id: user.id, type: 'Like', article_id: comment2.article_id }
        expect(Comment.all.last.likes.size).to(eq(2))
        expect(Comment.all.last.dislikes.size).to(eq(0))
        expect(Like.all.count).to(eq(2))
        expect(response).to(redirect_to(article_path(comment.article_id)))
      end
    end
  end

  describe '#dislike' do
    context 'when like not exists' do
      it 'create dislike, change comment and redirect to article path' do
        post '/login', params: user_params
        post '/preferences', params: { comment_id: comment.id, user_id: user.id, type: 'Dislike', article_id: comment.article_id }
        expect(Comment.all.last.dislikes.size).to(eq(1))
        expect(Dislike.all.count).to(eq(1))
        expect(response).to(redirect_to(article_path(comment.article_id)))
      end

      it 'redirect to login path if not user' do
        post '/preferences', params: { comment_id: comment.id, user_id: user.id, type: 'Dislike', article_id: comment.article_id }
        expect(response).to(redirect_to(login_path))
      end
    end

    context 'when like exists' do
      let!(:comment2) { create(:comment, commentable: article1, article_id: article1.id) }
      let!(:like)     { create(:preference, comment_id: comment2.id, user_id: admin.id, type: 'Like')   }
      let!(:dislike)  { create(:preference, comment_id: comment2.id, user_id: user.id, type: 'Dislike') }

      it 'remove dislike, change comment and redirect to article path' do
        post '/login', params: user_params
        post '/preferences', params: { comment_id: comment2.id, user_id: user.id, type: 'Dislike', article_id: comment2.article_id }
        expect(Comment.all.last.dislikes.size).to(eq(0))
        expect(Like.all.count).to(eq(1))
        expect(response).to(redirect_to(article_path(comment.article_id)))
      end

      it 'remove like, create dislike, change comment and redirect to article path' do
        post '/login', params: user_params
        post '/preferences', params: { comment_id: comment2.id, user_id: admin.id, type: 'Dislike', article_id: comment2.article_id }
        expect(Comment.all.last.dislikes.size).to(eq(2))
        expect(Comment.all.last.likes.size).to(eq(0))
        expect(Dislike.all.count).to(eq(2))
        expect(response).to(redirect_to(article_path(comment.article_id)))
      end
    end
  end
end
