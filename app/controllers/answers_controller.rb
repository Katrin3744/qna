class AnswersController < ApplicationController
  before_action :find_question, only: [:index, :new]
  def index
    @answers = @question.answers
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = @question.answers.new
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end
