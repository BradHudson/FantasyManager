#find first two F-link class nodes
# these have the team names
#
#ID of statTable1 has all the stats of non benched players
#ID of statTable2 has the bench
#
require 'nokogiri'
require 'pry'


page = Nokogiri::HTML(open("2017/WeekMatchupDetailed/1/game1.html"))

teams = []

teams.push(page.css('.F-link').first.children.text)
teams.push(page.css('.F-link')[1].children.text)

stats = {
    "Team_1": {
        "score": page.css('.Fz-xxl.Ta-end.Ptop-xxl.Pend-lg')[0].children.text,
        "projected":  page.css('.F-shade.Ta-end.Pend-lg.Fz-med.Pbot-xxl.Ptop-med')[0].children.text,
        "players": []
    },
    "Team_2": {
        "score": page.css('.Fz-xxl.Ta-start.Ptop-xxl.Pstart-lg')[0].children.text,
        "projected": page.css('.F-shade.Ta-start.Pstart-lg.Fz-med.Pbot-xxl.Ptop-med')[0].children.text,
        "players": []
    }
}

counter = 0
final_result = []
times_to_loop = page.css('.Ta-end.Fw-b.Nowrap.Va-top').length

times_to_loop.times do
    begin
      name = page.css('.ysf-player-name')[counter]&.children&.first&.text
      position = page.css('.ysf-player-name')[counter]&.children[2]&.children&.text
      if counter >= 20
        projected = page.css('.Alt.Ta-end.F-shade.Va-top')[counter+6]&.children&.children&.text
        actual = page.css('.Ta-end.Fw-b.Nowrap.Va-top')[counter+6]&.children&.last&.children&.text
      else
        projected = page.css('.Alt.Ta-end.F-shade.Va-top')[counter+2]&.children&.children&.text
        actual = page.css('.Ta-end.Fw-b.Nowrap.Va-top')[counter+2]&.children&.last&.children&.text
      end
      starter = counter <= 19
    rescue
      name ||= nil
      position ||= nil
      projected ||= nil
      actual ||= nil
      starter ||= nil
    end
    result = {
        "name": name,
        "position": position,
        "projected": projected,
        "actual": actual,
        "starter": starter
    }
    puts result
    if counter % 2 == 0
      stats[:Team_1][:players].push(result) unless result[:name] == nil
    else
      stats[:Team_2][:players].push(result) unless result[:name] == nil
    end
  counter += 1
end

puts stats
