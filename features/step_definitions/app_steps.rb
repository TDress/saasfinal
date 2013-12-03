Given /I am on the homepage/ do
  visit('/#/')
end

Then /there (?:should be|is) a ([A-z]+) called "([^\s]+)"/ do |tag, id|
  assert find("#{tag}##{id}").nil? === false
end

When /I click "([^\s]+)"/ do |id|
  click_button(id)
end

When /I log in with "([^"]+)" and "([^"]+)"/ do |username, password|
  click_button('logIn')

  browser = page.driver.browser

  popup = browser.window_handles.last
  app = browser.window_handles.first

  browser.switch_to.window(popup)

  fill_in("session_key-oauth2SAuthorizeForm", with: username)
  fill_in("session_password-oauth2SAuthorizeForm", with: password)

  find("#session_password-oauth2SAuthorizeForm").native.send_keys(:return)

  browser.switch_to.window(app)

  assert browser.window_handles.size === 1
end
