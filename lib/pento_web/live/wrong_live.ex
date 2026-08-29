defmodule PentoWeb.WrongLive do
require Logger
  use PentoWeb, :live_view


  def render(assigns) do
    ~H"""
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <h1 class="mb-4 text-4xl font-extrabold">Your score: {@score}</h1>
      <h2>{@message} It's &nbsp {time()}</h2>
      <br/>
      <h2 :if={@score < 3}>
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
      <h2 :if={@score == 3} >
        You won
        <.link class="btn btn-primary" phx-click="restart" >Restart</.link>
      </h2>
    </main>
    """
  end

  def mount(_params, _session, socket), do:
    {:ok, assign(socket, score: 0, message: "Guess 3. Make a guess:", rand_num: :rand.uniform(10))}

  def time, do: DateTime.utc_now() |> to_string()

  def handle_event("guess", %{"number" => guess}, socket) do
    IO.inspect(socket.assigns.rand_num)
    case String.to_integer(guess) === socket.assigns.rand_num do
      true  when socket.assigns.score < 3 ->
        message = "Your guess: #{guess}. Right. Continue. "
        score = socket.assigns.score + 1
        rand_num = :rand.uniform(10)
        IO.inspect(rand_num)

        {:noreply, assign(socket, message: message, score: score, rand_num: rand_num)}

      true  when socket.assigns.score == 3 ->
        message = "Your guess: #{guess}. You won. Continue. "

        {:noreply, assign(socket, message: message)}
      false ->
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1
        {:noreply,  assign(socket, message: message, score: score)}
    end
  end

  def handle_event("restart", _payload, socket) do
    {:noreply, assign(socket, score: 0, message: "Guess 3. Make a guess:", rand_num: :rand.uniform(10))}
  end
end
