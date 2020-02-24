defmodule AthenaWeb.Router do
  use AthenaWeb, :router

  @subresource_actions [:index, :new, :create]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/admin", AthenaWeb.Admin, as: :admin do
    pipe_through :browser

    get "/", EventController, :index
    resources "/events", EventController, except: [:index]
    resources "/events/:event/locations", LocationController, only: @subresource_actions
    resources "/locations", LocationController, except: @subresource_actions
    resources "/events/:event/item_groups", ItemGroupController, only: @subresource_actions
    resources "/item_groups", ItemGroupController, except: @subresource_actions
    resources "/item_groups/:item_group/items", ItemController, only: @subresource_actions
    resources "/items", ItemController, except: @subresource_actions
    resources "/items/:item/movements", MovementController, only: @subresource_actions
    resources "/movements", MovementController, except: @subresource_actions
  end

  scope "/logistics/", AthenaWeb.Frontend, as: :frontend_logistics do
    pipe_through :browser

    get "/locations/:id", LocationController, :show, assigns: %{access: :logistics}
    live "/events/:event/overview", LogisticsLive
  end

  scope "/vendor/", AthenaWeb.Frontend, as: :frontend_vendor do
    pipe_through :browser

    get "/locations/:id", LocationController, :show, assigns: %{access: :vendor}
  end

  # Other scopes may use custom stacks.
  # scope "/api", AthenaWeb do
  #   pipe_through :api
  # end
end
