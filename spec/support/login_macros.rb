module LoginMacros
  
  def login(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました"
  end
  
  def logout
    click_link "Log out"
    expect(page).to have_content "ログアウトしました"
  end
  
end