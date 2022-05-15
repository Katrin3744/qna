class AnswersController < ApplicationController
  before_action :find_answer, only: [:show, :destroy]
  before_action :find_question, only: [:index, :new, :create]

  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    if !user_signed_in?
      redirect_to new_user_session_path, flash: { error: 'You need to sign in or sign up before continuing.' }
    else
      @answer = current_user.answers.build(answer_params)
      @answer.question = @question
      if @answer.save
        redirect_to @answer, notice: 'Your answer successfully created.'
      else
        redirect_to @question, flash: { error: "Body can't be blank" }
      end
    end
  end

  def destroy
    if @answer.author == current_user
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
