defmodule HitchedWeb.ForgotPasswordLive do
  use HitchedWeb, :live_view

  alias Hitched.Accounts

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm text-center h-screen flex flex-col justify-center -mt-16">
      <p class="text-3xl text-center mb-4">🔗</p>
      <.header class="text-center">
        Forgot your password?
        <:subtitle>We'll send a password reset link to your inbox</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="reset_password_form"
        phx-submit="send_email"
        class="mb-1 rounded-2xl shadow-sm p-1 ring-1 ring-gray-200 mt-8"
      >
        <.input
          field={@form[:email]}
          type="email"
          label="Email"
          hide_label
          placeholder="Email"
          required
          autofocus
          class="relative block w-full rounded-xl border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-200 placeholder:text-gray-400 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-hitched-400 sm:text-sm sm:leading-6 bg-gray-100"
        />

        <.button
          phx-disable-with="Sending..."
          class="mt-1 flex w-full justify-center rounded-xl bg-hitched-600 hover:bg-hitched-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-hitched-700"
        >
          Send reset instructions
        </.button>
      </.simple_form>

      <p class="text-center text-sm mt-1 text-hitched-700">
        <.link href={~p"/register"} class="text-hitched-500 hover:text-hitched-600">Register</.link>
        | <.link href={~p"/login"} class="text-hitched-500 hover:text-hitched-600">Login</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
