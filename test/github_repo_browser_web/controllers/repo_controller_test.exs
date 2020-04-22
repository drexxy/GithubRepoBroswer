defmodule GithubRepoBrowserWeb.RepoControllerTest do
  use GithubRepoBrowserWeb.ConnCase

  test "GET /repos", %{conn: conn} do
    conn = get(conn, "/repos")
    assert html_response(conn, 200) =~ "Please enter an organizaion name and press enter"
  end
end
