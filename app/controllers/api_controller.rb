class ApiController < ApplicationController
    include Response
    include ExceptionHandler

    before_action :authorize_request
    attr_reader :current_author

    private
        def authorize_request
            @current_author = (AuthorizeApiRequest.new(request.headers).call)[:author]
        end
end