module RequestsHelper
  def manual_login(user, password = 'password')
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button "Log in"
  end

  def fill_in_na_store

  end

  def fill_in_playlist
    fill_in 'Name', with: Faker::Name.name
  end

  def wait_until(tries: 25, puts: nil)
    #expects block
    count = 0
    while count < tries
      sleep 0.1
      puts(puts) if puts
      if yield
        sleep 0.1
        return
      end

      count += 1
    end

    raise StandardError, "#wait_until tried #{tries} times, but failed to yeild true in block given."
  end
end
