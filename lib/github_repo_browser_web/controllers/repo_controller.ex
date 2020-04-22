defmodule GithubRepoBrowserWeb.RepoController do
  use GithubRepoBrowserWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
