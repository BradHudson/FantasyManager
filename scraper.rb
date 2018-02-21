require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'pry'

agent = Mechanize.new

login = agent.get('https://football.fantasysports.yahoo.com/f1/105480')
login_form = login.forms.first
username_field = login_form.field_with(:name => "username")
username_field.value = ''
page  = login_form.click_button

login_form = page.forms.first
password_field = login_form.field_with(:name => "password")
password_field.value = ''
button = page.form.button_with(name: "verifyPassword")
login_form.click_button(button)



URLs = [
    # #week 16
    # "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=16&mid1=7&mid2=2",
    # #week 15 FIXXXX
    # "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=15&mid1=7&mid2=9",
    # "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=15&mid1=2&mid2=6",
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
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=8&mid1=7&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=8&mid1=1&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=8&mid1=2&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=8&mid1=3&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=8&mid1=4&mid2=5",
    #week 7
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=7&mid1=7&mid2=2",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=7&mid1=1&mid2=4",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=7&mid1=3&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=7&mid1=5&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=7&mid1=6&mid2=9",
    #week 6
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=6&mid1=7&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=6&mid1=1&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=6&mid1=2&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=6&mid1=3&mid2=4",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=6&mid1=8&mid2=9",
    #week 5
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=5&mid1=7&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=5&mid1=1&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=5&mid1=2&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=5&mid1=3&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=5&mid1=4&mid2=10",
    #week 4
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=4&mid1=7&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=4&mid1=1&mid2=3",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=4&mid1=2&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=4&mid1=4&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=4&mid1=5&mid2=6",
    #week 3
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=3&mid1=7&mid2=8",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=3&mid1=1&mid2=2",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=3&mid1=3&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=3&mid1=4&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=3&mid1=6&mid2=10",
    #week 2
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=2&mid1=7&mid2=4",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=2&mid1=1&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=2&mid1=2&mid2=5",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=2&mid1=3&mid2=10",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=2&mid1=6&mid2=8",
    #week 1
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=1&mid1=7&mid2=1",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=1&mid1=2&mid2=3",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=1&mid1=4&mid2=6",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=1&mid1=5&mid2=9",
    "https://football.fantasysports.yahoo.com/f1/105480/matchup?week=1&mid1=8&mid2=10",
]


#week 15 and 16

# page = agent.get("https://football.fantasysports.yahoo.com/f1/105480/matchup?week=16&mid1=7&mid2=2")
# output = File.open( "2017/WeekMatchupDetailed/16/game1.html","w" )
# output << page.body
# output.close
#
# page = agent.get("https://football.fantasysports.yahoo.com/f1/105480/matchup?week=15&mid1=7&mid2=9")
# output = File.open( "2017/WeekMatchupDetailed/15/game1.html","w" )
# output << page.body
# output.close
#
# page = agent.get("https://football.fantasysports.yahoo.com/f1/105480/matchup?week=15&mid1=2&mid2=6")
# output = File.open( "2017/WeekMatchupDetailed/15/game2.html","w" )
# output << page.body
# output.close


week = 14
game = 1
URLs.each do |url|
  page = agent.get(url)
  output = File.open( "2017/WeekMatchupDetailed/#{ week }/game#{ game }.html","w" )
  output << page.body
  output.close
  if game == 5
    week -= 1
    game = 1
    next
  end
  game += 1
end


