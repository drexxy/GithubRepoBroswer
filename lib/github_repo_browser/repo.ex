defmodule GithubRepoBrowser.Repo do
  use Ecto.Repo,
    otp_app: :github_repo_browser,
    adapter: Ecto.Adapters.Postgres
end
