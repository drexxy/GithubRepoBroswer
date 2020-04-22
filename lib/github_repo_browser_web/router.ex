defmodule GithubRepoBrowserWeb.Router do
  use GithubRepoBrowserWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GithubRepoBrowserWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GithubRepoBrowserWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/repos", RepoController, only: [:index]
  end

  scope "/auth", GithubRepoBrowserWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", GithubRepoBrowserWeb do
  #   pipe_through :api
  # end
end
