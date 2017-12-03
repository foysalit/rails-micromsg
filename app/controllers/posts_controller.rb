class PostsController < ApiController
    before_action :set_post, only: [:show, :destroy]
    skip_before_action :authorize_request, only: :search

    # GET /posts
    def index
        @posts = current_author.posts
        json_response(@posts)
    end

    # GET /posts/search
    def search
        keyword = request.query_parameters["keyword"]

        if !keyword
            return json_response("Please specify a keyword", 422)
        end

        @posts = Post
            .where("content LIKE ?", "%#{keyword}%")
            .where(hidden: false)
            .where(author: Author.where(blocked: false))
            .all
            
        json_response(@posts)
    end

    # POST /posts
    def create
        puts post_params.inspect
        @post = current_author.posts.create!(post_params)
        json_response(@post, :created)
    end

    # GET /posts/:id
    def show
        json_response(@post)
    end

    # DELETE /posts/:id
    def destroy
        @post.destroy
        head :no_content
    end

    private

    def post_params
        # whitelist params
        params.permit(:content)
    end

    def set_post
        @post = current_author.posts.find(params[:id])
    end
end
