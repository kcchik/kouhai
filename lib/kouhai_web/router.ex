defmodule KouhaiWeb.Router do
  use KouhaiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug KouhaiWeb.Plugs.Authentication
  end

  scope "/", KouhaiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", KouhaiWeb do
    pipe_through :api
    post "/login", UserController, :login

    pipe_through :authenticate
    resources "/users", UserController do
      resources "/posts", PostController
    end
  end
end
