defmodule PaymentWeb.ProductLive.Show do
  use PaymentWeb, :live_view

  alias Payment.Products

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  @spec handle_params(map(), any(), %{
          :assigns => atom() | %{:live_action => :edit | :show, optional(any()) => any()},
          optional(any()) => any()
        }) :: {:noreply, map()}
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, Products.get_product!(id))}
  end

  @impl true
  def handle_event("pay", params, socket) do
    api_key = System.get_env("CHAPTER_API_KEY")

    email = params["email"]
    fullname = params["name"]
    phone_number = params["phone_number"]
    url = "https://api.chpter.co/v1/initiate/mpesa-payment"

    body = %{
      "customer_details" => %{
        "email" => email,
        "full_name" => fullname,
        "phone_number" => phone_number,
        "location" => "Nairobi"
      },
      "products" => [
        %{
          "product_name" => "toy",
          "quantity" => 1,
          "unit_price" => 1,
          "digital_link" => "https://example.com"
        }
      ],
      "amount" => %{
        "currency" => "KES",
        "delivery_fee" => 0.0,
        "discount_fee" => 0.0,
        "total" => 1
      },
      "callback_details" => %{
        "notify_customer" => true,
        "transaction_reference" => phone_number,
        "callback_url" => "https://1fa5-196-207-151-132.ngrok-free.app/api/mpesas"
      }
    }

    headers = [
      {
        "Content-Type",
        "application/json"
      },
      {
        "Api-Key",
        api_key
      }
    ]

    request_body = Poison.encode!(body)

    case IO.inspect HTTPoison.post(url, request_body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: _body}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Prompt Sent")}

      {:ok, %HTTPoison.Response{status_code: 400, body: _body}} ->
        {:noreply, put_flash(socket, :error, "Payment Failed")}

      _ ->
        {:noreply, put_flash(socket, :error, "Payment Failed")}
    end

    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
