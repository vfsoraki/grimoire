defmodule WithGrimoire do
  import Grimoire

  defstruct [:field_a, :field_b]

  grimoire do
    def some_fn(a), do: {a.field_a, a.field_b}
  end
end

defmodule WithoutGrimoire do
  defstruct [:field_a]
end

defmodule GrimoireTest do
  use ExUnit.Case
  import Grimoire

  describe "a grimoire" do
    test "does work when called correctly" do
      st = %WithGrimoire{field_a: :a, field_b: :b}

      assert {:a, :b} = st ~> some_fn
    end

    test "raises when function is not defined" do
      st = %WithGrimoire{field_a: :a, field_b: :b}

      assert_raise UndefinedFunctionError, fn ->
        st ~> some_fn(:a)
      end
    end
  end

  describe "not a grimoire" do
    test "raises" do
      st = %WithoutGrimoire{field_a: :a}

      assert_raise Grimoire.NotGrimoireError, fn ->
        st ~> some_fn
      end
    end
  end
end
