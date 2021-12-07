defmodule Grimoire do
  @moduledoc """
  Superchared Elixir structs.
  """

  defmodule NotGrimoireError do
    defexception [:module, :message]

    @impl true
    def exception(module) do
      %__MODULE__{module: module, message: "#{inspect(module)} is not a known grimoire yet."}
    end
  end

  defmacro grimoire(do: block) do
    quote do
      defmodule Grimoire do
        unquote(block)
      end
    end
  end

  defmacro s ~> f do
    {field, _, args} = f
    args = if is_list(args), do: args, else: []
    args = [s | args]
    args_count = Enum.count(args)

    quote bind_quoted: [f: field, a: args, ac: args_count, s: s] do
      schema_mod = s.__struct__

      mod =
        Module.split(schema_mod)
        |> Enum.concat([Grimoire])
        |> Module.concat()

      cond do
        function_exported?(mod, f, ac) ->
          apply(mod, f, a)

        f in Map.keys(s) ->
          s
          |> Map.from_struct()
          |> Map.get(f)

        function_exported?(mod, :__info__, 1) ->
          defined_functions = mod.__info__(:functions)

          error =
            if {f, ac} in defined_functions, do: FunctionClauseError, else: UndefinedFunctionError

          raise error, module: schema_mod, function: f, arity: ac

        true ->
          raise NotGrimoireError, schema_mod
      end
    end
  end
end
