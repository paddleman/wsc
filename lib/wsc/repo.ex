defmodule Wsc.Repo do
  use Ecto.Repo,
    otp_app: :wsc,
    adapter: Ecto.Adapters.Postgres
end

defmodule Wsc.WscRepo do
  use Ecto.Repo,
    otp_app: :wsc,
    adapter: Ecto.Adapters.Postgres
end
