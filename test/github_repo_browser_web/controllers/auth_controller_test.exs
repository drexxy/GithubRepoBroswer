defmodule GithubRepoBrowserWeb.AuthControllerTest do
  use GithubRepoBrowserWeb.ConnCase

  alias GithubRepoBrowser.Accounts.User
  alias GithubRepoBrowser.Accounts
  alias GithubRepoBrowser.Repo

  test "callback/2 creates a user if one does not exist with the provided email and sets their id to the session", %{conn: conn} do
    nickname = "Ben"
    email = "ben@ben.com"
    token = "123456789ABC"
    conn = assign(conn, :ueberauth_auth, %{info: %{nickname: nickname, email: email }, credentials: %{token: token }})

    conn = get(conn, Routes.auth_path(conn, :callback, "github"))
    assert html_response(conn, 302)

    new_user = Repo.get_by!(User, username: nickname)
    assert new_user.email == email
    assert new_user.token == token
    assert new_user.provider == "github"
    assert get_session(conn, :user_id) == new_user.id
  end

  test "callback/2 does not create a user if one already exists with the provided email and sets their id to the session", %{conn: conn} do
    nickname = "Ben"
    email = "ben@ben.com"
    token = "123456789ABC"
    {:ok, user} = Accounts.create_user(%{username: nickname, email: email, token: token, provider: "github"})
    initial_user_count = Repo.aggregate(User, :count)

    conn = assign(conn, :ueberauth_auth, %{info: %{nickname: nickname, email: email }, credentials: %{token: token }})
    conn = get(conn, Routes.auth_path(conn, :callback, "github"))

    assert html_response(conn, 302)
    assert initial_user_count == Repo.aggregate(User, :count)
    assert get_session(conn, :user_id) == user.id
  end
end
