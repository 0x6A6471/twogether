defmodule Hitched.Repo do
  use Ecto.Repo,
    otp_app: :hitched,
    adapter: Ecto.Adapters.Postgres
end
