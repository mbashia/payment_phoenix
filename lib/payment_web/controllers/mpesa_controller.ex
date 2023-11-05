defmodule PaymentWeb.MpesaController do
  use PaymentWeb, :controller

  alias Payment.Mpesas
  alias Payment.Mpesas.Mpesa

  action_fallback PaymentWeb.FallbackController

  def index(conn, _params) do
    mpesas = Mpesas.list_mpesas()
    render(conn, "index.json", mpesas: mpesas)
  end

  def create(conn, params) do
    IO.inspect(params)

    new_mpesa_transaction_params = %{
      "message" => params["Message"],
      "success" => params["Success"],
      "status" => params["Status"],
      "amount" => params["Amount"],
      "transaction_code" => params["transaction_code"],
      "transaction_reference" => params["transaction_reference"]
    }

    with {:ok, %Mpesa{} = mpesa} <- Mpesas.create_mpesa(new_mpesa_transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.mpesa_path(conn, :show, mpesa))
      |> render("show.json", mpesa: mpesa)
    end
  end

  def show(conn, %{"id" => id}) do
    mpesa = Mpesas.get_mpesa!(id)
    render(conn, "show.json", mpesa: mpesa)
  end

  def update(conn, %{"id" => id, "mpesa" => mpesa_params}) do
    mpesa = Mpesas.get_mpesa!(id)

    with {:ok, %Mpesa{} = mpesa} <- Mpesas.update_mpesa(mpesa, mpesa_params) do
      render(conn, "show.json", mpesa: mpesa)
    end
  end

  def delete(conn, %{"id" => id}) do
    mpesa = Mpesas.get_mpesa!(id)

    with {:ok, %Mpesa{}} <- Mpesas.delete_mpesa(mpesa) do
      send_resp(conn, :no_content, "")
    end
  end
end
