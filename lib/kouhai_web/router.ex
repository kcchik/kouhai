defmodule KouhaiWeb.Router do
  use KouhaiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug KouhaiWeb.Plugs.Authenticate
  end

  # Unprotected (account required)
  scope "/", KouhaiWeb do
    pipe_through :api

    post "/sign_in", UserController, :sign_in
    post "/sign_up", UserController, :sign_up
    resources "/users", UserController, only: [:index, :show] do
      get "/following", FollowController, :following
      get "/followers", FollowController, :followers
      get "/picture", UserPictureController, :show
      resources "/posts", PostController, only: [:index]
    end
    resources "/posts", PostController, only: [:show] do
      resources "/comments", CommentController, only: [:index]
      get "/upvotes", PostVoteController, :upvote_count
      get "/downvotes", PostVoteController, :downvote_count
    end
    resources "/comments", CommentController, only: [] do
      get "/upvotes", CommentVoteController, :upvote_count
      get "/downvotes", CommentVoteController, :downvote_count
    end
  end

  # Protected (account required)
  scope "/", KouhaiWeb do
    pipe_through :api
    pipe_through :authenticate

    resources "/users", UserController, only: [:update, :delete]
    resources "/follows", FollowController, only: [:update, :delete]
    post "/picture", UserPictureController, :update
    delete "/picture", UserPictureController, :delete
    get "/feed", PostController, :feed
    resources "/posts", PostController, only: [:create, :update, :delete] do
      resources "/comments", CommentController, only: [:create]
      post "/upvote", PostVoteController, :upvote
      post "/downvote", PostVoteController, :downvote
    end
    resources "/comments", CommentController, only: [:update, :delete] do
      post "/upvote", CommentVoteController, :upvote
      post "/downvote", CommentVoteController, :downvote
    end
  end
end
