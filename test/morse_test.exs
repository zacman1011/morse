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
      assert catch_throw(Morse.from_morse("#{@dash} #{@dot} #{@dot} #{@dot} #{@dash}")) == "Invalid combination does not convert to letter: \"- . . . -\""
    end

  end

  describe "to_morse/1" do

    test "Single letter" do
      assert Morse.to_morse("a") == "#{@dot} #{@dash}"
      assert Morse.to_morse("b") == "#{@dash} #{@dot} #{@dot} #{@dot}"
      assert Morse.to_morse("c") == "#{@dash} #{@dot} #{@dash} #{@dot}"
      assert Morse.to_morse("d") == "#{@dash} #{@dot} #{@dot}"
      assert Morse.to_morse("e") == "#{@dot}"
      assert Morse.to_morse("f") == "#{@dot} #{@dot} #{@dash} #{@dot}"
      assert Morse.to_morse("g") == "#{@dash} #{@dash} #{@dot}"
      assert Morse.to_morse("h") == "#{@dot} #{@dot} #{@dot} #{@dot}"
      assert Morse.to_morse("i") == "#{@dot} #{@dot}"
      assert Morse.to_morse("j") == "#{@dot} #{@dash} #{@dash} #{@dash}"
      assert Morse.to_morse("k") == "#{@dash} #{@dot} #{@dash}"
      assert Morse.to_morse("l") == "#{@dot} #{@dash} #{@dot} #{@dot}"
      assert Morse.to_morse("m") == "#{@dash} #{@dash}"
      assert Morse.to_morse("n") == "#{@dash} #{@dot}"
      assert Morse.to_morse("o") == "#{@dash} #{@dash} #{@dash}"
      assert Morse.to_morse("p") == "#{@dot} #{@dash} #{@dash} #{@dot}"
      assert Morse.to_morse("q") == "#{@dash} #{@dash} #{@dot} #{@dash}"
      assert Morse.to_morse("r") == "#{@dot} #{@dash} #{@dot}"
      assert Morse.to_morse("s") == "#{@dot} #{@dot} #{@dot}"
      assert Morse.to_morse("t") == "#{@dash}"
      assert Morse.to_morse("u") == "#{@dot} #{@dot} #{@dash}"
      assert Morse.to_morse("v") == "#{@dot} #{@dot} #{@dot} #{@dash}"
      assert Morse.to_morse("w") == "#{@dot} #{@dash} #{@dash}"
      assert Morse.to_morse("x") == "#{@dash} #{@dot} #{@dot} #{@dash}"
      assert Morse.to_morse("y") == "#{@dash} #{@dot} #{@dash} #{@dash}"
      assert Morse.to_morse("z") == "#{@dash} #{@dash} #{@dot} #{@dot}"
    end

    test "Single number" do
      assert Morse.to_morse("1") == "#{@dot} #{@dash} #{@dash} #{@dash} #{@dash}"
      assert Morse.to_morse("2") == "#{@dot} #{@dot} #{@dash} #{@dash} #{@dash}"
      assert Morse.to_morse("3") == "#{@dot} #{@dot} #{@dot} #{@dash} #{@dash}"
      assert Morse.to_morse("4") == "#{@dot} #{@dot} #{@dot} #{@dot} #{@dash}"
      assert Morse.to_morse("5") == "#{@dot} #{@dot} #{@dot} #{@dot} #{@dot}"
      assert Morse.to_morse("6") == "#{@dash} #{@dot} #{@dot} #{@dot} #{@dot}"
      assert Morse.to_morse("7") == "#{@dash} #{@dash} #{@dot} #{@dot} #{@dot}"
      assert Morse.to_morse("8") == "#{@dash} #{@dash} #{@dash} #{@dot} #{@dot}"
      assert Morse.to_morse("9") == "#{@dash} #{@dash} #{@dash} #{@dash} #{@dot}"
      assert Morse.to_morse("0") == "#{@dash} #{@dash} #{@dash} #{@dash} #{@dash}"
    end

    test "Single word" do
      assert Morse.to_morse("sos") == "#{@dot} #{@dot} #{@dot}   #{@dash} #{@dash} #{@dash}   #{@dot} #{@dot} #{@dot}"
    end

    test "Multiple words" do
      assert Morse.to_morse("hello world") == "#{@dot} #{@dot} #{@dot} #{@dot}   #{@dot}   #{@dot} #{@dash} #{@dot} #{@dot}   #{@dot} #{@dash} #{@dot} #{@dot}   #{@dash} #{@dash} #{@dash}       #{@dot} #{@dash} #{@dash}   #{@dash} #{@dash} #{@dash}   #{@dot} #{@dash} #{@dot}   #{@dot} #{@dash} #{@dot} #{@dot}   #{@dash} #{@dot} #{@dot}"
    end

    test "Illegal combination throws error" do
      assert catch_throw(Morse.to_morse("@")) == "Invalid character that cannot be converted to morse code: \"@\""
    end

  end

end
