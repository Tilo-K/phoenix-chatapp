defmodule ChatappWeb.PageController do
  use ChatappWeb, :controller

  def home(conn, _params) do
    msg = [
      %{author: "test author", message: "This is a test message"}
    ]
    render(conn, :home,messages: msg, layout: false)
  end

  def send(conn, params) do
    
  end
end
