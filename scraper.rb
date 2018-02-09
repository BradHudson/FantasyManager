require 'nokogiri'
require 'mechanize'
require 'open-uri'
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
button = page.form.button_with(name: "verifyPassword")
binding.pry
page  = login_form.click_button(button)
binding.pry
first_page = agent.get("https://football.fantasysports.yahoo.com/f1/105480/matchup?week=14&mid1=7&mid2=8")
first_page.parser.css('#statTable1')
first_page.body

#ysf-player-class

puts 'blah'
URLs = [
    #week 14
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=14&mid1=7&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=14&mid1=1&mid2=2",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=14&mid1=3&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=14&mid1=4&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=14&mid1=6&mid2=10",
    #week 13
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=13&mid1=7&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=13&mid1=1&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=13&mid1=2&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=13&mid1=3&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=13&mid1=4&mid2=10",
    #week 12
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=12&mid1=7&mid2=4",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=12&mid1=1&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=12&mid1=2&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=12&mid1=3&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=12&mid1=6&mid2=8",
    #week 11
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=11&mid1=7&mid2=1",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=11&mid1=2&mid2=3",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=11&mid1=4&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=11&mid1=5&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=11&mid1=8&mid2=10",
    #week 10
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=10&mid1=7&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=10&mid1=1&mid2=3",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=10&mid1=2&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=10&mid1=4&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=10&mid1=5&mid2=6",
    #week 9
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=9&mid1=7&mid2=3",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=9&mid1=1&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=9&mid1=2&mid2=4",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=9&mid1=5&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=9&mid1=9&mid2=10",
    #week 8
    "",
    "",
    "",
    "",
    "",
    #week 7
    "",
    "",
    "",
    "",
    "",
    #week 6
    "",
    "",
    "",
    "",
    "",
    #week 5
    "",
    "",
    "",
    "",
    "",
    #week 4
    "",
    "",
    "",
    "",
    "",
    #week 3
    "",
    "",
    "",
    "",
    "",
    #week 2
    "",
    "",
    "",
    "",
    "",
    #week 1
    "",
    "",
    "",
    "",
    "",
]

