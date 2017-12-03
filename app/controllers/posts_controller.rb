class PostsController < ApiController
    before_action :set_post, only: [:show, :destroy]

    # GET /posts
    def index
        @posts = current_author.posts
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
