require 'nokogiri'
require 'mechanize'
require 'pry'

agent = Mechanize.new

login = agent.get('https://football.fantasysports.yahoo.com/f1/105480')
login_form = login.forms.first
username_field = login_form.field_with(:name => "username")
username_field.value = "blah"
page  = login_form.click_button

login_form = page.forms.first
password_field = login_form.field_with(:name => "password")
password_field.value = 'blah'
page  = login_form.click_button(button)
