class Users::SessionsController < Devise::SessionsController
  respond_to :json
  
  private
  
  def respond_with(resource, _opts = {})
    if resource.persisted?
      # Generate JWT token
      token = resource.generate_jwt
      
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
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
        status: { code: 401, message: 'Invalid email or password.' }
      }, status: :unauthorized
    end
  end
  
  def respond_to_on_destroy
    head :no_content
  end
end