defmodule GithubRepoBrowserWeb.Router do
  use GithubRepoBrowserWeb, :router

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

  scope "/", GithubRepoBrowserWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/repos", RepoController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", GithubRepoBrowserWeb do
  #   pipe_through :api
  # end
end
