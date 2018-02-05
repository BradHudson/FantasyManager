require 'spreadsheet'
require 'json'
require 'pry'

def calculate_results
  results = {}

  team = ''
  opponent = ''
  week = 0
  year = ''
  overall_wins = 0
  overall_loss = 0
  overall_pts_for = 0
  overall_pts_against = 0

  year_wins = 0
  year_loss = 0
  year_pts_for = 0
  year_pts_against = 0


  opponent_wins = 0
  opponent_loss = 0
  opponent_pts_for = 0
  opponent_pts_against = 0


  book = Spreadsheet.open('dynasty_weeks_stats.xls')
  sheet1 = book.worksheet('Sheet1') # can use an index or worksheet name
  sheet1.each do |row|
    unless row[0].nil? || row[0].to_s.empty?
      team = row[0]
      results[team.to_sym] = {} unless results.key?(team)
      results[team.to_sym][:pts_for] = 0 unless results[team.to_sym].key?(:pts_for)
      results[team.to_sym][:pts_against] = 0 unless results[team.to_sym].key?(:pts_against)
      results[team.to_sym][:wins] = 0 unless results[team.to_sym].key?(:wins)
      results[team.to_sym][:loss] = 0 unless results[team.to_sym].key?(:loss)
    end
    unless row[1].nil?
      year = row[1].to_s
      results[team.to_sym][year.to_sym] = {} unless results[team.to_sym].key?(year)
    end
    unless row[2].nil?
      week = row[2]
    end
    unless row[3].nil?
      opponent = row[3]
      results[team.to_sym][year.to_sym][opponent.to_sym] = {} unless results[team.to_sym][year.to_sym].key?(opponent.to_sym)
      results[team.to_sym][year.to_sym][opponent.to_sym][:wins] = 0 unless results[team.to_sym][year.to_sym][opponent.to_sym].key?(:wins)
      results[team.to_sym][year.to_sym][opponent.to_sym][:loss] = 0 unless results[team.to_sym][year.to_sym][opponent.to_sym].key?(:loss)
      results[team.to_sym][year.to_sym][opponent.to_sym][:pts_for] = 0 unless results[team.to_sym][year.to_sym][opponent.to_sym].key?(:pts_for)
      results[team.to_sym][year.to_sym][opponent.to_sym][:pts_against] = 0 unless results[team.to_sym][year.to_sym][opponent.to_sym].key?(:pts_against)

      results[team.to_sym][opponent.to_sym] = {} unless results[team.to_sym].key?(opponent.to_sym)
      results[team.to_sym][opponent.to_sym][:wins] = 0 unless results[team.to_sym][opponent.to_sym].key?(:wins)
      results[team.to_sym][opponent.to_sym][:loss] = 0 unless results[team.to_sym][opponent.to_sym].key?(:loss)
      results[team.to_sym][opponent.to_sym][:pts_for] = 0 unless results[team.to_sym][opponent.to_sym].key?(:pts_for)
      results[team.to_sym][opponent.to_sym][:pts_against] = 0 unless results[team.to_sym][opponent.to_sym].key?(:pts_against)
    end
    unless row[4].nil?
      results[team.to_sym][:wins] += 1 if row[4].downcase == 'win'
      results[team.to_sym][:loss] += 1 if row[4].downcase == 'loss'

      results[team.to_sym][year.to_sym][opponent.to_sym][:wins] += 1 if row[4].downcase == 'win'
      results[team.to_sym][year.to_sym][opponent.to_sym][:loss] += 1 if row[4].downcase == 'loss'

      results[team.to_sym][opponent.to_sym][:wins] += 1 if row[4].downcase == 'win'
      results[team.to_sym][opponent.to_sym][:loss] += 1 if row[4].downcase == 'loss'
    end
    unless row[5].nil?
      scores = row[5].split(' - ')
      results[team.to_sym][:pts_for] += scores[0].to_f
      results[team.to_sym][:pts_against] += scores[1].to_f

      results[team.to_sym][year.to_sym][opponent.to_sym][:pts_for] += scores[0].to_f
      results[team.to_sym][year.to_sym][opponent.to_sym][:pts_against] += scores[1].to_f

      results[team.to_sym][opponent.to_sym][:pts_for] += scores[0].to_f
      results[team.to_sym][opponent.to_sym][:pts_against] += scores[1].to_f
    end
  end


  File.open("temp_stats.json","w") do |f|
    f.write(results.to_json)
  end
end


def format_results
  results = JSON.parse(File.read('temp_stats.json'))
  teams = ["30 Rack of Matty Ice", "Rick James Bitch", "Midget Kickers", "George W Kush", "Nanny is heating up", "Just the Tip", "Not Payton's Team", "Julio's your daddy", "Swinging Moose Root", "Chlamydia"]
  years = ["2015.0", "2016.0", "2017.0"]
  new_result = []
  index = 0

  results.each do |key, array|
    new_result.push(
        {
            "Team Name": key,
            "Year": "",
            "Opponent": "",
            "W-L Overall": "",
            "Pts For": "",
            "Pts Against": "",
            "Streak": "",
            "Largest Margin of Victory": "",
            "Worst Loss": ""
        })

    teams.each do |team|
      next if team == key
      new_result.push(
          {
              "Team Name": '',
              "Year": "",
              "Opponent": team,
              "W-L Overall": "'#{ results[key][team]['wins'] } - #{ results[key][team]['loss'] }'",
              "Pts For": results[key][team]['pts_for'],
              "Pts Against": results[key][team]['pts_against'],
              "Streak": "",
              "Largest Margin of Victory": "",
              "Worst Loss": ""
          })
    end
    years.each do |year|
      teams.each do |team|
        next if team == key
        begin
          new_result.push(
              {
                  "Team Name": '',
                  "Year": year,
                  "Opponent": team,
                  "W-L Overall": "'#{ results[key][year][team]['wins'] } - #{ results[key][year][team]['loss'] }'",
                  "Pts For": results[key][year][team]['pts_for'],
                  "Pts Against": results[key][year][team]['pts_against'],
                  "Streak": "",
                  "Largest Margin of Victory": "",
                  "Worst Loss": ""
              })
        rescue
          puts "Problem is " + key + ' ' + year + ' ' + team
        end
      end
    end
  end

  File.open("final_stats.json","w") do |f|
    f.write(new_result.to_json)
  end
end


format_results