defmodule ChatappWeb.PageController do
  use ChatappWeb, :controller

  @messages_agent_name __MODULE__

  def child_spec(_args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link do
    Agent.start_link(fn -> [] end, name: @messages_agent_name)
  end

  def messages do
    Agent.get(@messages_agent_name, & &1)
  end

  def add_message(message) do
    Agent.update(@messages_agent_name, &(&1 ++ [message]))
  end

  def home(conn, _params) do
    render(conn, :home, messages: messages(), layout: false)
  end

  def send(conn, params) do
    add_message(%{author: "test author", message: params["message"]})

    conn
    |> put_status(200)
    |> json(%{msg: params["message"]})
  end

  def get_messages(conn, _params) do
    conn
    |> put_status(200)
    |> json(messages())
  end
end
