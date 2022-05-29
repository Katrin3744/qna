require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question,
                                         answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer in the database' do
        expect { post :create, params: { question_id: question,
                                         answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      it 're-renders question show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:answer) { create :answer, question: question, author: user }

    context 'with user that is author' do
      it 'delete answer from database' do
        expect { delete :destroy, params: { question_id: question, id: answer } }.to change(question.answers, :count).by(-1)
      end

      it 'redirects to question show view' do
        delete :destroy, params: { question_id: question, id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'with user that is not author' do
      let!(:user_not_author) { create(:user) }
      before do
        logout(user)
        login(user_not_author)
      end

      it "don't delete answer from database" do
        expect { delete :destroy, params: { question_id: question, id: answer } }.to_not change(question.answers, :count)
      end

      it 'redirects to question show view' do
        delete :destroy, params: { question_id: question, id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
