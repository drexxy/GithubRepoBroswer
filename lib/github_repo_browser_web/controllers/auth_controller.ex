defmodule GithubRepoBrowserWeb.AuthController do
  use GithubRepoBrowserWeb, :controller

  plug Ueberauth

  def callback(conn, _params) do

  end
end
