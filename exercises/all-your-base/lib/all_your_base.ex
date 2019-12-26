defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  def convert([], _, _), do: nil
  def convert(_, base_a, base_b) when base_a <= 1 or base_b <= 1, do: nil

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    result =
      Enum.reduce_while(digits, {:ok, 0}, fn digit, {_, acc} ->
        if digit < 0 or digit >= base_a do
          {:halt, {:error, acc}}
        else
          {:cont, {:ok, acc * base_a + digit}}
        end
      end)

    case result do
      {:error, _} -> nil
      {:ok, num} -> do_convert(num, [], base_b)
    end
  end

  defp do_convert(num, list, base_b) do
    reminder = rem(num, base_b)
    num = div(num, base_b)

    case num do
      0 -> [reminder | list]
      _ -> do_convert(num, [reminder | list], base_b)
    end
  end
end
