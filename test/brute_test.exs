defmodule BruteTest do
  use ExUnit.Case, async: true
  doctest Brute

  test "it generates a list ranging from a-z when the param is 1" do
    list = Brute.alpha(1)
    assert list == ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  end

  test "it generates a list ranging from aa, ab ... zy zz" do
    list = Brute.alpha(2)
    r_list = Enum.reverse(list)

    assert "aa" in list
    assert "ab" in list
    assert "zy" in r_list
    assert "zz" in r_list
  end

  test "it generates a list for length 3" do
    list = Brute.alpha(3)
    r_list = Enum.reverse(list)

    assert "aaa" in list
    assert "aab" in list
    assert "zzy" in r_list
    assert "zzz" in r_list
  end
end

