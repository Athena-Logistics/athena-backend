defmodule AthenaWeb.Admin.Navigation do
  @moduledoc false

  use AthenaWeb, :component

  alias Athena.Inventory.ItemGroup
  alias Athena.Inventory.Location

  attr :event, Athena.Inventory.Event, required: true
  attr :conn, Plug.Conn, required: true
  attr :item_groups, :list, required: true

  def navigation(assigns) do
    ~H"""
    <nav class="navbar navbar-expand-lg navbar-light bg-primary mb-5">
      <div class="container-fluid">
        <a href={Routes.admin_event_path(@conn, :index)} class="navbar-brand">
          <img src={Routes.static_path(@conn, "/images/icon.png")} width="30" />
          <%= @event.name %>
        </a>
        <label
          for="toggle-nav"
          class="navbar-toggler"
          type="button"
          aria-controls="navbarNavDropdown"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </label>
        <input type="checkbox" id="toggle-nav" hidden />
        <main class="navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav">
            <li class="nav-item">
              <.link navigate={Routes.admin_location_path(@conn, :index, @event)} class="nav-link">
                <%= gettext("locations") %>
              </.link>
            </li>
            <li class="nav-item dropdown">
              <label
                class="nav-link dropdown-toggle"
                for="toggle-nav-locations"
                role="button"
                aria-expanded="false"
              >
                <%= gettext("locations") %>
              </label>
              <input type="checkbox" id="toggle-nav-locations" hidden class="toggle-dropdown" />
              <ul class="dropdown-menu show">
                <li :for={%Location{name: location_name} = location <- @locations} class="nav-item">
                  <.link
                    navigate={Routes.admin_location_path(@conn, :show, location)}
                    class="dropdown-item"
                  >
                    <%= location_name %>
                  </.link>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <.link navigate={Routes.admin_item_group_path(@conn, :index, @event)} class="nav-link">
                <%= gettext("item groups") %>
              </.link>
            </li>
            <li class="nav-item dropdown">
              <label
                class="nav-link dropdown-toggle"
                for="toggle-nav-item-groups"
                role="button"
                aria-expanded="false"
              >
                <%= gettext("item groups") %>
              </label>
              <input type="checkbox" id="toggle-nav-item-groups" hidden class="toggle-dropdown" />
              <ul class="dropdown-menu show">
                <li
                  :for={%ItemGroup{name: item_group_name} = item_group <- @item_groups}
                  class="nav-item"
                >
                  <.link
                    navigate={Routes.admin_item_group_path(@conn, :show, item_group)}
                    class="dropdown-item"
                  >
                    <%= item_group_name %>
                  </.link>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <.link navigate={Routes.live_dashboard_path(@conn, :home)} class="nav-link">
                <%= gettext("dashboard") %>
              </.link>
            </li>
          </ul>
        </main>
      </div>
    </nav>
    """
  end
end
