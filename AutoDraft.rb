require 'pry'
require 'csv'


$teams = {
    1 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    2 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    3 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    4 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    5 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    6 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    7 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    8 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    9 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    10 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    11 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    12 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    13 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    14 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    15 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    },
    16 => {
        "QB" => [],
        "RB"=> [],
        "WR"=> [],
        "TE"=> [],
        "FX"=> []
    }
}

$players_taken = []

def draft_player(team)
  position = position_needed(team)
  team[1][position].push(find_player(position))
end

def position_needed(team)
  return 'WR' if team[1]["WR"].length < 3
  return 'RB' if team[1]["RB"].length < 2
  return 'QB' if team[1]["QB"].length < 1
  return 'FX' if team[1]["FX"].length  < 1
  return 'TE' if team[1]["TE"].length < 1

end

def find_player(position)
  position = 'WR' if position == 'FX'
  $csv.each do |row|
    if row[4][0..1] == position[0..1] && !$players_taken.include?(row[2])
      $players_taken.push(row[2])
      return row[2]
    end
  end
end

csv_text = File.read('rankings.csv')
$csv = CSV.parse(csv_text, :headers => true)

(1..8).each do |i|
  $teams.each do |team|
    draft_player(team)
  end
end

$teams.each do |team|
  puts team
end









