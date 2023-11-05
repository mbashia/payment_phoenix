defmodule Payment.MpesasTest do
  use Payment.DataCase

  alias Payment.Mpesas

  describe "mpesas" do
    alias Payment.Mpesas.Mpesa

    import Payment.MpesasFixtures

    @invalid_attrs %{
      amount: nil,
      message: nil,
      status: nil,
      success: nil,
      transaction_code: nil,
      transaction_reference: nil
    }

    test "list_mpesas/0 returns all mpesas" do
      mpesa = mpesa_fixture()
      assert Mpesas.list_mpesas() == [mpesa]
    end

    test "get_mpesa!/1 returns the mpesa with given id" do
      mpesa = mpesa_fixture()
      assert Mpesas.get_mpesa!(mpesa.id) == mpesa
    end

    test "create_mpesa/1 with valid data creates a mpesa" do
      valid_attrs = %{
        amount: 120.5,
        message: "some message",
        status: 42,
        success: true,
        transaction_code: "some transaction_code",
        transaction_reference: "some transaction_reference"
      }

      assert {:ok, %Mpesa{} = mpesa} = Mpesas.create_mpesa(valid_attrs)
      assert mpesa.amount == 120.5
      assert mpesa.message == "some message"
      assert mpesa.status == 42
      assert mpesa.success == true
      assert mpesa.transaction_code == "some transaction_code"
      assert mpesa.transaction_reference == "some transaction_reference"
    end

    test "create_mpesa/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mpesas.create_mpesa(@invalid_attrs)
    end

    test "update_mpesa/2 with valid data updates the mpesa" do
      mpesa = mpesa_fixture()

      update_attrs = %{
        amount: 456.7,
        message: "some updated message",
        status: 43,
        success: false,
        transaction_code: "some updated transaction_code",
        transaction_reference: "some updated transaction_reference"
      }

      assert {:ok, %Mpesa{} = mpesa} = Mpesas.update_mpesa(mpesa, update_attrs)
      assert mpesa.amount == 456.7
      assert mpesa.message == "some updated message"
      assert mpesa.status == 43
      assert mpesa.success == false
      assert mpesa.transaction_code == "some updated transaction_code"
      assert mpesa.transaction_reference == "some updated transaction_reference"
    end

    test "update_mpesa/2 with invalid data returns error changeset" do
      mpesa = mpesa_fixture()
      assert {:error, %Ecto.Changeset{}} = Mpesas.update_mpesa(mpesa, @invalid_attrs)
      assert mpesa == Mpesas.get_mpesa!(mpesa.id)
    end

    test "delete_mpesa/1 deletes the mpesa" do
      mpesa = mpesa_fixture()
      assert {:ok, %Mpesa{}} = Mpesas.delete_mpesa(mpesa)
      assert_raise Ecto.NoResultsError, fn -> Mpesas.get_mpesa!(mpesa.id) end
    end

    test "change_mpesa/1 returns a mpesa changeset" do
      mpesa = mpesa_fixture()
      assert %Ecto.Changeset{} = Mpesas.change_mpesa(mpesa)
    end
  end
end
