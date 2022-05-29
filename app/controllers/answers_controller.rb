class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: :destroy
  before_action :find_question, only: [:index, :create]

  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question = @question
    if @answer.save
      redirect_to @answer.question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to @answer.question, notice: 'Your answer successfully deleted.'
    else
      redirect_to @answer.question, flash: { error: "You don't have permission for that" }
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
