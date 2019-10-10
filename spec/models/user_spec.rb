require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validation' do
    it 'should have valid factory' do
      user = build :user
      expect(user).to be_valid
    end

    it 'should validate presence of attributes' do
      user = build :user, login: nil, provider: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:login]).to include("can't be blank")
      expect(user.errors.messages[:provider]).to include("can't be blank")
    end

    # it 'should validate uniqueness of login' do
    #   user = create :user
    #   user1 = create :user, login: user.login
    #   expect(user1).not_to be_valid
    #   user1.login = 'logmein'
    #   expect(user1).to be_valid
    # end
  end
end
