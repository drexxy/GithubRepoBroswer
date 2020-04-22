defmodule GithubRepoBrowserWeb.AuthController do
  use GithubRepoBrowserWeb, :controller

  alias GithubRepoBrowser.Accounts.User
  alias GithubRepoBrowser.Repo

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{username: auth.info.nickname, email: auth.info.email, token: auth.credentials.token, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Signed in successfully")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
