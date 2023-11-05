defmodule PaymentWeb.MpesaControllerTest do
  use PaymentWeb.ConnCase

  import Payment.MpesasFixtures

  alias Payment.Mpesas.Mpesa

  @create_attrs %{
    amount: 120.5,
    message: "some message",
    status: 42,
    success: true,
    transaction_code: "some transaction_code",
    transaction_reference: "some transaction_reference"
  }
  @update_attrs %{
    amount: 456.7,
    message: "some updated message",
    status: 43,
    success: false,
    transaction_code: "some updated transaction_code",
    transaction_reference: "some updated transaction_reference"
  }
  @invalid_attrs %{
    amount: nil,
    message: nil,
    status: nil,
    success: nil,
    transaction_code: nil,
    transaction_reference: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all mpesas", %{conn: conn} do
      conn = get(conn, Routes.mpesa_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mpesa" do
    test "renders mpesa when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mpesa_path(conn, :create), mpesa: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.mpesa_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => 120.5,
               "message" => "some message",
               "status" => 42,
               "success" => true,
               "transaction_code" => "some transaction_code",
               "transaction_reference" => "some transaction_reference"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mpesa_path(conn, :create), mpesa: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mpesa" do
    setup [:create_mpesa]

    test "renders mpesa when data is valid", %{conn: conn, mpesa: %Mpesa{id: id} = mpesa} do
      conn = put(conn, Routes.mpesa_path(conn, :update, mpesa), mpesa: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.mpesa_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => 456.7,
               "message" => "some updated message",
               "status" => 43,
               "success" => false,
               "transaction_code" => "some updated transaction_code",
               "transaction_reference" => "some updated transaction_reference"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, mpesa: mpesa} do
      conn = put(conn, Routes.mpesa_path(conn, :update, mpesa), mpesa: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete mpesa" do
    setup [:create_mpesa]

    test "deletes chosen mpesa", %{conn: conn, mpesa: mpesa} do
      conn = delete(conn, Routes.mpesa_path(conn, :delete, mpesa))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.mpesa_path(conn, :show, mpesa))
      end
    end
  end

  defp create_mpesa(_) do
    mpesa = mpesa_fixture()
    %{mpesa: mpesa}
  end
end
