defmodule HiddenInputUpdateWeb.LivePage do
  use HiddenInputUpdateWeb, :live_view

  alias HiddenInputUpdateWeb.TestComponent
  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       change_params: nil,
       submit_params: nil,
       ts_change: nil,
       ts_submit: nil,
       value: 0
     )}
  end

  def handle_event("change", params, socket) do
    {:noreply, assign(socket, change_params: inspect(params), ts_change: DateTime.utc_now())}
  end

  def handle_event("submit", params, socket) do
    {:noreply, assign(socket, submit_params: inspect(params), ts_submit: DateTime.utc_now())}
  end

  def handle_event("trigger_change", _params, socket) do
    {:noreply, push_event(socket, "trigger_change", %{})}
  end

  def handle_event("increase", _params, socket) do
    socket =
      socket
      |> update(:value, &(&1 + 1))
      |> push_event("trigger_input", %{})

    {:noreply, socket}
  end
end
