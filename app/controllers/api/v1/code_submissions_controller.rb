class Api::V1::CodeSubmissionsController < ApplicationController
  before_action :set_code_submission, only: [:show, :update, :destroy]
  
  # GET /api/v1/code_submissions
  def index
    @code_submissions = CodeSubmission.all
    render json: @code_submissions
  end

  # GET /api/v1/code_submissions/:id
  def show
    render json: @code_submission
  end

  # POST /api/v1/code_submissions
  def create
    @code_submission = CodeSubmission.new(code_submission_params)
    
    @code_submission.user = User.first if User.any?
    
    if @code_submission.save
      render json: @code_submission, status: :created
    else
      render json: { errors: @code_submission.errors.full_messages }, 
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/code_submissions/:id
  def update
    if @code_submission.update(code_submission_params)
      render json: @code_submission
    else
      render json: { errors: @code_submission.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/code_submissions/:id
  def destroy
    @code_submission.destroy
    head :no_content
  end

  private
  
  def set_code_submission
    @code_submission = CodeSubmission.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Code submission not found" }, status: :not_found
  end

  def code_submission_params
    params.require(:code_submission).permit(:content, :language)
  end
end