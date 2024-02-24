defmodule Morse do
  @moduledoc """
  Documentation for `Morse`.
  """

  @blank " "
  @dot "."
  @dash "-"
  @available_characters [@dot, @dash, @blank]

  @acc_starter ""
  @current_starter ""

  @conversion [
    {"a", "#{@dot} #{@dash}"},
    {"b", "#{@dash} #{@dot} #{@dot} #{@dot}"},
    {"c", "#{@dash} #{@dot} #{@dash} #{@dot}"},
    {"d", "#{@dash} #{@dot} #{@dot}"},
    {"e", "#{@dot}"},
    {"f", "#{@dot} #{@dot} #{@dash} #{@dot}"},
    {"g", "#{@dash} #{@dash} #{@dot}"},
    {"h", "#{@dot} #{@dot} #{@dot} #{@dot}"},
    {"i", "#{@dot} #{@dot}"},
    {"j", "#{@dot} #{@dash} #{@dash} #{@dash}"},
    {"k", "#{@dash} #{@dot} #{@dash}"},
    {"l", "#{@dot} #{@dash} #{@dot} #{@dot}"},
    {"m", "#{@dash} #{@dash}"},
    {"n", "#{@dash} #{@dot}"},
    {"o", "#{@dash} #{@dash} #{@dash}"},
    {"p", "#{@dot} #{@dash} #{@dash} #{@dot}"},
    {"q", "#{@dash} #{@dash} #{@dot} #{@dash}"},
    {"r", "#{@dot} #{@dash} #{@dot}"},
    {"s", "#{@dot} #{@dot} #{@dot}"},
    {"t", "#{@dash}"},
    {"u", "#{@dot} #{@dot} #{@dash}"},
    {"v", "#{@dot} #{@dot} #{@dot} #{@dash}"},
    {"w", "#{@dot} #{@dash} #{@dash}"},
    {"x", "#{@dash} #{@dot} #{@dot} #{@dash}"},
    {"y", "#{@dash} #{@dot} #{@dash} #{@dash}"},
    {"z", "#{@dash} #{@dash} #{@dot} #{@dot}"},
    {"1", "#{@dot} #{@dash} #{@dash} #{@dash} #{@dash}"},
    {"2", "#{@dot} #{@dot} #{@dash} #{@dash} #{@dash}"},
    {"3", "#{@dot} #{@dot} #{@dot} #{@dash} #{@dash}"},
    {"4", "#{@dot} #{@dot} #{@dot} #{@dot} #{@dash}"},
    {"5", "#{@dot} #{@dot} #{@dot} #{@dot} #{@dot}"},
    {"6", "#{@dash} #{@dot} #{@dot} #{@dot} #{@dot}"},
    {"7", "#{@dash} #{@dash} #{@dot} #{@dot} #{@dot}"},
    {"8", "#{@dash} #{@dash} #{@dash} #{@dot} #{@dot}"},
    {"9", "#{@dash} #{@dash} #{@dash} #{@dash} #{@dot}"},
    {"0", "#{@dash} #{@dash} #{@dash} #{@dash} #{@dash}"}
  ]

  @letters_morse Map.new(@conversion)
  @morse_letters Map.new(@conversion, fn({letter, morse}) -> {morse, letter} end)

  @doc """
    Converts a morse-code message into plain English
  """
  @spec from_morse(String.t()) :: String.t()
  def from_morse(input) do
    input
    |> String.graphemes()
    |> convert_morse()
  end

  defp convert_morse(tokens, current \\ @current_starter, acc \\ @acc_starter)
  defp convert_morse([], current, acc) do
    ## End of sequence so add letter and trim the end in case last token added was the end of a word
    "#{acc}#{convert_morse_letter(current)}" |> String.trim_trailing()
  end
  defp convert_morse([@blank, @blank, @blank, @blank, @blank, @blank, @blank | rest], current, acc) do
    ## End of word so add letter and then a space and continue to next word
    convert_morse(rest, @current_starter, "#{acc}#{convert_morse_letter(current)} ")
  end
  defp convert_morse([@blank, @blank, @blank | rest], current, acc) do
    ## End of letter so add letter and continue to next letter
    convert_morse(rest, @current_starter, "#{acc}#{convert_morse_letter(current)}")
  end
  # defp convert_morse([@blank | rest], current, acc) do
  #   ## Space between characters so ignore and carry on building letter
  #   convert_morse(rest, current, acc)
  # end
  defp convert_morse([next | rest], current, acc) when next in @available_characters do
    ## Where the next grapheme is acceptable, append it to current to add to the current letter build
    convert_morse(rest, "#{current}#{next}", acc)
  end

  defp convert_morse_letter(""), do: ""
  defp convert_morse_letter(" "), do: ""
  defp convert_morse_letter(letter) do
    case Map.fetch(@morse_letters, letter) do
      {:ok, letter} ->
        letter

      :error ->
        throw("Invalid combination does not convert to letter: #{inspect letter}")
    end
  end

  @doc """
    Converts plaintext to morse code
  """
  @spec to_morse(String.t()) :: String.t()
  def to_morse(morse) do
    morse
    |> String.graphemes()
    |> convert_plaintext()
  end

  defp convert_plaintext(graphemes, last \\ nil, acc \\ "")
  defp convert_plaintext([], _last, acc) do
    ## Finished conversion so trim spaces and return
    String.trim(acc)
  end
  defp convert_plaintext([" " | rest], _last, acc) do
    ## If space then we have reached the end of a word so add the end of word marker (7 spaces)
    convert_plaintext(rest, " ", "#{acc}       ")
  end
  defp convert_plaintext([next | rest], last, acc) do
    ## Add the 3 spaces that mark end of a letter if last was not a space or the start and then add the morse conversion for the letter
    spacing = if is_nil(last) or last == " " do
      ""
    else
      "   "
    end
    letter = convert_letter(next)
    convert_plaintext(rest, letter, "#{acc}#{spacing}#{letter}")
  end

  defp convert_letter(letter) do
    case Map.fetch(@letters_morse, letter) do
      {:ok, morse} ->
        morse

      :error ->
        throw("Invalid character that cannot be converted to morse code: #{inspect letter}")
    end
  end

end
