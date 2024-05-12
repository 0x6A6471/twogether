defmodule HitchedWeb.LoginLive do
  use HitchedWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm text-center h-screen flex flex-col justify-center -mt-16">
      <p class="text-3xl text-center mb-8">🔗</p>

      <.simple_form
        for={@form}
        id="login_form"
        action={~p"/login"}
        phx-update="ignore"
        class="mb-1 rounded-2xl shadow-sm p-1 ring-1 ring-gray-200"
      >
        <div>
          <.input
            field={@form[:email]}
            type="email"
            label="Email"
            hide_label
            placeholder="Email"
            required
            autofocus
            class="relative block w-full rounded-t-xl border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-200 placeholder:text-gray-400 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-hitched-400 sm:text-sm sm:leading-6 bg-gray-100"
          />

          <.input
            field={@form[:password]}
            type="password"
            label="Password"
            hide_label
            placeholder="Password"
            required
            class="relative block w-full rounded-b-xl border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-200 placeholder:text-gray-400 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-hitched-400 sm:text-sm sm:leading-6 bg-gray-100"
          />

          <.button
            phx-disable-with="Logging in..."
            class="mt-1 flex w-full justify-center rounded-xl bg-hitched-600 hover:bg-hitched-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-hitched-700"
          >
            Login
          </.button>
        </div>
      </.simple_form>

      <.link
        href={~p"/reset_password"}
        class="text-center text-sm text-hitched-500 hover:text-hitched-600"
      >
        Forgot password?
      </.link>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
