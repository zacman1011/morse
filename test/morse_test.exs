defmodule MorseTest do
  use ExUnit.Case
  doctest Morse

  @dot "."
  @dash "-"

  describe "from_morse/1" do

    test "Single letter" do
      assert Morse.from_morse("#{@dot} #{@dash}") == "a"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dot} #{@dot}") == "b"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dash} #{@dot}") == "c"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dot}") == "d"
      assert Morse.from_morse("#{@dot}") == "e"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dash} #{@dot}") == "f"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dot}") == "g"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot} #{@dot}") == "h"
      assert Morse.from_morse("#{@dot} #{@dot}") == "i"
      assert Morse.from_morse("#{@dot} #{@dash} #{@dash} #{@dash}") == "j"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dash}") == "k"
      assert Morse.from_morse("#{@dot} #{@dash} #{@dot} #{@dot}") == "l"
      assert Morse.from_morse("#{@dash} #{@dash}") == "m"
      assert Morse.from_morse("#{@dash} #{@dot}") == "n"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dash}") == "o"
      assert Morse.from_morse("#{@dot} #{@dash} #{@dash} #{@dot}") == "p"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dot} #{@dash}") == "q"
      assert Morse.from_morse("#{@dot} #{@dash} #{@dot}") == "r"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot}") == "s"
      assert Morse.from_morse("#{@dash}") == "t"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dash}") == "u"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot} #{@dash}") == "v"
      assert Morse.from_morse("#{@dot} #{@dash} #{@dash}") == "w"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dot} #{@dash}") == "x"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dash} #{@dash}") == "y"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dot} #{@dot}") == "z"
    end

    test "Single number" do
      assert Morse.from_morse("#{@dot} #{@dash} #{@dash} #{@dash} #{@dash}") == "1"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dash} #{@dash} #{@dash}") == "2"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot} #{@dash} #{@dash}") == "3"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot} #{@dot} #{@dash}") == "4"
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot} #{@dot} #{@dot}") == "5"
      assert Morse.from_morse("#{@dash} #{@dot} #{@dot} #{@dot} #{@dot}") == "6"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dot} #{@dot} #{@dot}") == "7"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dash} #{@dot} #{@dot}") == "8"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dash} #{@dash} #{@dot}") == "9"
      assert Morse.from_morse("#{@dash} #{@dash} #{@dash} #{@dash} #{@dash}") == "0"
    end

    test "Single word" do
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot}   #{@dash} #{@dash} #{@dash}   #{@dot} #{@dot} #{@dot}       ") == "sos"
    end

    test "Multiple words" do
      assert Morse.from_morse("#{@dot} #{@dot} #{@dot} #{@dot}   #{@dot}   #{@dot} #{@dash} #{@dot} #{@dot}   #{@dot} #{@dash} #{@dot} #{@dot}   #{@dash} #{@dash} #{@dash}       #{@dot} #{@dash} #{@dash}   #{@dash} #{@dash} #{@dash}   #{@dot} #{@dash} #{@dot}   #{@dot} #{@dash} #{@dot} #{@dot}   #{@dash} #{@dot} #{@dot}       ") == "hello world"
    end

    test "Just a gap between dots and dashes returns empty string" do
      assert Morse.from_morse(" ") == ""
    end

    test "Just a gap between letters returns empty string" do
      assert Morse.from_morse("   ") == ""
    end

    test "Just a gap between words returns empty string" do
      assert Morse.from_morse("       ") == ""
    end

    test "Illegal combination throws error" do
      assert catch_throw(Morse.from_morse("#{@dash} #{@dot} #{@dot} #{@dot} #{@dash}")) == "Invalid combination does not convert to letter: \"-...-\""
    end

  end

end
