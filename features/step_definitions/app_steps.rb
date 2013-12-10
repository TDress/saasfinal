Given /^I am on the homepage$/ do
  visit('/#/')
end

Then /^there should( not)? be a ([A-z]+) called "([^\s]+)"$/ do |neg, tag, id|
  assert first("#{tag}##{id}").nil? === !neg.nil?
end

When /^I click "([^\s]+)"$/ do |id|
  click_button(id)
end

When /^I try to log in but deny permission/ do
  step "I click \"logIn\""

  browser = page.driver.browser

  popup = browser.window_handles.last
  app = browser.window_handles.first

  browser.switch_to.window(popup)

	find("a.cancel").native.click

  browser.switch_to.window(app)

  assert browser.window_handles.size === 1
end

When /^I log in with "([^"]+)" and "([^"]+)"$/ do |username, password|
  step "I click \"logIn\""

  browser = page.driver.browser

  popup = browser.window_handles.last
  app = browser.window_handles.first

  browser.switch_to.window(popup)

  fill_in("session_key-oauth2SAuthorizeForm", with: username)
  fill_in("session_password-oauth2SAuthorizeForm", with: password)

  find("#session_password-oauth2SAuthorizeForm").native.submit

  browser.switch_to.window(app)

  assert browser.window_handles.size === 1
end

Then /^I should see "([^"])+"$/ do |e1|
	expect(find("body").native.attribute("innerHTML")).to match(/#{e1}/m)
end

Then /^I should see "([^"]+)" before "([^"])+"$/ do |e1, e2|
	expect(find("body").native.attribute("innerHTML")).to match(/#{e1}.*#{e2}/m)
end

Given /^the following users have been created:/ do |users_table|
	users_table.hashes.each do |user|
		User.create!(user)
	end
end

Given /^the following posts have been created:/ do |posts_table|
	posts_table.hashes.each do |post|
		post[:user] = User.find_by_id(post[:user])
		post[:created_on] = DateTime.strptime(post[:created_on], '%Y-%m-%d')
		Post.create!(post)
	end
end

When /^(?:|I )press the first button with class "([^"]*)"$/ do |buttonclass|
	button = find("button[class='#{buttonclass}']")
	button.click
end

When /^(?:|I )press "([^"]*)"$/ do |button|
	click_button("#{button}")
end

When /^I click the "(.*)" link$/ do |link|
	click_link(link)
end

When /^I enter "([^"]*)" in the "([^"]*)" field$/i do |value, fieldname|
  fill_in "#{fieldname}", :with => value
end
