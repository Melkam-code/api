require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
   describe '#create' do
     shared_examples_for "unauthorized_requests" do
       let(:error) do
          {
          "status" => "401",
          "source" => { "pointer" => "/code" },
          "title" => "Authentication code is invalid",
          "detail" => "You must provide valid code in order to exchange if for token."
          }
     end

     it 'should return 401 status code' do
       subject
       expect(response).to have_http_status(401)
     end

     it 'should return proper error body' do
       subject
       expect(json['errors']).to include(error)
     end
     end

     context 'when no code provided' do
       subject { post :create }
       it_behaves_like "unauthorized_requests"
     end

     context 'when invalid code provided' do
       let(:github_error) {
         double("Sawyer::Resource", error: "bad_verification_code")
       }
       before do
         allow_any_instance_of(Octokit::Client).to receive(
           :exchange_code_for_token).and_return(github_error)
       end

       subject { post :create, params: { code: 'invalid_code' } }
       it_behaves_like "unauthorized_requests"
     end

     context 'when success request' do
       subject { post :create, params: { code: 'valid_code' } }
       let(:user_data) do
         {
         login: 'jss',
         url: 'http://blabla.com',
         avatar_url: 'http://avatarme.com',
         name: 'kartoon black'
       }
       end
       before do
         allow_any_instance_of(Octokit::Client).to receive(
           :exchange_code_for_token).and_return('validaccesstoken')
         allow_any_instance_of(Octokit::Client).to receive(
           :user).and_return(user_data)
       end

       it 'should return 201 status code' do
         subject
         expect(response).to have_http_status(:created)
       end

       it 'should return proper json body' do
         expect{ subject }.to change{ User.count }.by(1)
         user = User.find_by(login: 'jss')
         token = user.access_token
         pp token.token
         pp token.reload.token
         pp json['access_token']
         expect(json['access_token'].except("id")).to eq(
           { 'token' => user.access_token.token }
         )
       end
     end
   end
end