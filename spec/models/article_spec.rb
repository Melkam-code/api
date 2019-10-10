require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validation' do
  it "should test that the factory is valid" do
  expect(FactoryBot.build :article).to be_valid
end

  it "should validate the presence of title" do
  article = FactoryBot.build :article, title: ''
  expect(article).not_to be_valid
  expect(article.errors.messages[:title]).to include("can't be blank")
end

  it "should validate the presence of content" do
    article = FactoryBot.build :article, content: ''
    expect(article).not_to be_valid
    expect(article.errors.messages[:content]).to include("can't be blank")
  end

  it "should validate the presence of slug" do
    article = FactoryBot.build :article, slug: ''
    expect(article).not_to be_valid
    expect(article.errors.messages[:slug]).to include("can't be blank")
  end
end

  describe '.recent' do
    it 'should list recent article first' do
      old_article = FactoryBot.create :article
      new_article = FactoryBot.create :article
      expect(described_class.recent).to eq(
        [ new_article, old_article ]
      )
    end
  end

end
