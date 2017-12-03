class AuthorizeApiRequest
    def initialize(headers = {})
        @headers = headers
    end

    def call 
        { author: author }
    end

    private
        attr_reader :headers

        def author
            @author ||= Author.find_by_username_and_device_id(auth_headers["Username"], auth_headers["DeviceId"]) if auth_headers
            
            # handle user not found
            if !@author
                raise(ExceptionHandler::InvalidAuth, ("No user found with provided credentials."))
            end

            @author
        end

        def auth_headers
            if (headers['Username'].present? && headers['DeviceId'].present?)
                return headers
            end
            
            raise(ExceptionHandler::MissingAuth, "Unauthorized user")
        end
end