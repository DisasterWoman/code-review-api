class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  def create
    build_resource(sign_up_params)
    
    resource.save
    if resource.persisted?
      token = resource.generate_jwt
      
      render json: {
        status: { 
          code: 200, 
          message: 'Signed up successfully.' 
        },
        data: {
          user: {
            id: resource.id,
            email: resource.email
          }
        },
        token: token
      }, status: :ok
    else
      render json: {
        status: { 
          code: 422, 
          message: "User couldn't be created." 
        },
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
  
  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end