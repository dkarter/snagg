defmodule Snagg.Mailer do
  @moduledoc """
  Interface for sending emails
  """

  use Swoosh.Mailer, otp_app: :snagg
end
