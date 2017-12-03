class AuthorsController < ApiController
    skip_before_action :authorize_request, only: :create

    # author /authors
    def create
        @author = Author.create!(author_params)
        json_response(@author, :created)
    end

    # GET /authors/:id
    def update
        current_author.update(author_params)
        json_response(current_author, :ok)
    end

    private

        def author_params
            # whitelist params
            params.permit(:username, :device_id, :hidden)
        end
end
