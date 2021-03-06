defmodule CycleChanger.Router do
  use CycleChanger.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
  end

  scope "/", CycleChanger do
    pipe_through :browser # Use the default browser stack

    get "/", ItemController, :index
    resources "/items", ItemController
  end

  # Other scopes may use custom stacks.
  scope "/api", CycleChanger do
    pipe_through :api

    get "/items/level", ItemController, :level
    resources "/items", ItemController
  end
end
