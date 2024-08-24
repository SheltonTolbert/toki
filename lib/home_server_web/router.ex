defmodule HomeServerWeb.Router do
  use HomeServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HomeServerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HomeServerWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", HomeServerWeb do
    pipe_through :api

    get "/config", ConfigController, :get_config

    post "/sensors", SensorController, :create
    post "/data", DataController, :create
  end

  if Application.compile_env(:home_server, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HomeServerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
