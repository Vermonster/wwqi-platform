def sign_in(user)
  login_as user, scope: :user, run_callbacks: false
end

def sign_out
  logout(:user)
end
