class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  before_action :find_question, only: [:destroy, :show]

  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers.all
    @answer = @question.answers.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    if @question.author == current_user
      @question.destroy
      redirect_to questions_path, notice: 'Your question successfully deleted.'
    else
      redirect_to questions_path, flash: { error: "You don't have permission for that" }
    end
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
