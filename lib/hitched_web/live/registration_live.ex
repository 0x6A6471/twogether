defmodule HitchedWeb.RegistrationLive do
  use HitchedWeb, :live_view

  alias Hitched.Accounts
  alias Hitched.Accounts.User

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm text-center h-screen flex flex-col justify-center -mt-16">
      <p class="text-3xl text-center mb-8">🔗</p>

      <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        action={~p"/login?_action=registered"}
        method="post"
        class="mb-1 rounded-2xl shadow-sm p-1 ring-1 ring-gray-200"
      >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>

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
          phx-disable-with="Creating account..."
          class="mt-1 flex w-full justify-center rounded-xl bg-hitched-600 hover:bg-hitched-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-hitched-700"
        >
          Create an account
        </.button>
      </.simple_form>

      <p class="text-center text-sm">
        Already have an account?
        <.link href={~p"/login"} class="text-hitched-500 hover:text-hitched-600">
          Login
        </.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
