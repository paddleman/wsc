defmodule Wsc.Utilities do
  def pretty_num(float, decs) do
    :erlang.float_to_binary(float, decimals: decs)
  end
end
