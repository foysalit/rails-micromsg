module ExceptionHandler
    # provides the more graceful `included` method
    extend ActiveSupport::Concern

    class AuthenticationError < StandardError; end
    class MissingAuth < StandardError; end
    class InvalidAuth < StandardError; end

    included do
        rescue_from ActiveRecord::RecordInvalid, with: :auth_error
        rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
        rescue_from ExceptionHandler::MissingAuth, with: :auth_error
        rescue_from ExceptionHandler::InvalidAuth, with: :auth_error
        
        rescue_from ActiveRecord::RecordNotFound do |e|
            json_response({ message: e.message }, :not_found)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
            json_response({ message: e.message }, :unprocessable_entity)
        end
    end

    private

        # JSON response with message; Status code 422 - unprocessable entity
        def auth_error(e)
            json_response({ message: e.message }, :unprocessable_entity)
        end

        # JSON response with message; Status code 401 - Unauthorized
        def unauthorized_request(e)
            json_response({ message: e.message }, :unauthorized)
        end
end