defmodule PaymentWeb.MpesaView do
  use PaymentWeb, :view
  alias PaymentWeb.MpesaView

  def render("index.json", %{mpesas: mpesas}) do
    %{data: render_many(mpesas, MpesaView, "mpesa.json")}
  end

  def render("show.json", %{mpesa: mpesa}) do
    %{data: render_one(mpesa, MpesaView, "mpesa.json")}
  end

  def render("mpesa.json", %{mpesa: mpesa}) do
    %{
      id: mpesa.id,
      message: mpesa.message,
      success: mpesa.success,
      status: mpesa.status,
      amount: mpesa.amount,
      transaction_code: mpesa.transaction_code,
      transaction_reference: mpesa.transaction_reference
    }
  end
end
