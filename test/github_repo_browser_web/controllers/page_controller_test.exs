defmodule GithubRepoBrowserWeb.PageControllerTest do
  use GithubRepoBrowserWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to the Github Repo Browser!"
  end
end
