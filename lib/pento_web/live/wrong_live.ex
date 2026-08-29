defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view


  def mount(_params, _session, socket), do:
    {:ok, assign(socket, score: 0, message: "Make a guess:")}

  def render(assigns) do
    ~H"""
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <h1 class="mb-4 text-4xl font-extrabold">Your score: {@score}</h1>
      <h2>{@message}</h2>
      <br/>
      <h2>
        <%= for n <- 1..10 do %>
          <.link
            class="btn btn-secondary"
            phx-click="guess"
            phx-value-number={n}
          >
            {n}
          </.link>
        <% end %>
      </h2>
    </main>
    """
  end
end
