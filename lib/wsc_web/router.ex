defmodule WscWeb.Router do
  use WscWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WscWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WscWeb do
    pipe_through :browser

    live "/", SplashLive

    live "/stations", StationLive.Index, :index
    live "/stations/new", StationLive.Index, :new
    live "/stations/:id/edit", StationLive.Index, :edit

    live "/stations/:id", StationLive.Show, :show
    live "/stations/:id/show/edit", StationLive.Show, :edit

    # get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", WscWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:wsc, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WscWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
