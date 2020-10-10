defmodule Wsc.Repo do
  use Ecto.Repo,
    otp_app: :wsc,
    adapter: Ecto.Adapters.Postgres
end
