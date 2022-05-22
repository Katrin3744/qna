require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }

  describe '#author_of?' do
    let(:user) { create :user }
    let(:user_not_author) { create :user }
    let(:question) { create :question, author: user }
    let(:answer) { create :answer, question: question, author: user }

    it 'should be true when answer belongs to user' do
      expect(user.author_of?(answer)).to be true
    end

    it 'should be false when answer does not belong to user' do
      expect(user_not_author.author_of?(answer)).to be false
    end

    it 'should be true when question belongs to user' do
      expect(user.author_of?(question)).to be true
    end

    it 'should be false when question does not belong to user' do
      expect(user_not_author.author_of?(answer)).to be false
    end
  end
end
