defmodule WscWeb.SplashLive do
  use WscWeb, :live_view

  def mount(_params, _session, socket) do
    # socket = assign(socket, key: value)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-center text-red-500 font-semibold">Splash Live</h1>
    """
  end
end
