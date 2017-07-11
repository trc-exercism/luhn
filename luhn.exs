defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
      |> _pad_number
      |> String.split("", trim: true)
      |> Enum.with_index
      |> Enum.reduce(0, fn({ digit, index }, acc) -> acc + _interpret_digit(digit, index) end)
  end

  defp _pad_number(number) do
    cond do
      rem(String.length(number), 2) == 0 -> number
      true -> "0" <> number
    end
  end

  defp _interpret_digit(digit, index) do
    cond do
      rem(index, 2) == 0 ->
        cond do
          String.to_integer(digit) * 2 > 9 -> (String.to_integer(digit) * 2) - 9
          true -> String.to_integer(digit) * 2
        end
      true -> String.to_integer(digit)
    end
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    number <> _get_digit(number)
  end

  defp _get_digit(number), do: to_string(rem(10 - rem(checksum(number <> "0"), 10), 10))
end
