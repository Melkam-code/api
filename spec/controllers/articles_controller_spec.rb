require 'rails_helper'

describe ArticlesController do
  describe '#index' do
    subject { get :index }

    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      FactoryBot.create_list :article, 2
      subject
      expect(json_data[0]['title']).to eq("My awesome title 2")
      expect(json_data[1]['id']).to eq(1)
    end

    it 'should return articles in the proper order' do
      old_article = FactoryBot.create :article
      new_article = FactoryBot.create :article
      subject
      expect(json_data.first['id']).to eq(new_article.id)
      expect(json_data.last['id']).to eq(old_article.id)
    end

    it 'should paginate results' do
      FactoryBot.create_list :article, 3
      get :index, params: { page: 2, per_page: 1 }
      expect(json_data.length).to eq(1)
      expect(json_data.first['id']).to eq(Article.recent.second.id)
    end
  end

  describe '#create' do
    subject { post :create }
    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end
  end
end
