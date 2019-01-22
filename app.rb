require 'bundler'
require 'csv'

Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)

require 'app/scrapper'


$page_mairie = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html")
$my_hash = $page_mairie.mairies


#pour le .json
def to_json
 File.open("db/emails.json","w") do |f|
 f.write($my_hash.to_json)
 end
end


#pour le .csv
def to_csv
$hash_my = $my_hash.map { |c| c.join(",") }.join("\n")
CSV.open("db/emails.csv", "wb") do |element|
  element << ["#{$hash_my}"]
end
end


#pour le google spreadsheet
def save_as_spreadsheet

session = GoogleDrive::Session.from_config("config.json")
# First worksheet of
# https://docs.google.com/spreadsheets/d/19fXbxVaXn9knKHPAQMuuMsiKH_Q50cN5jlj6K3H8VQc/edit#gid=0
ws = session.spreadsheet_by_key("19fXbxVaXn9knKHPAQMuuMsiKH_Q50cN5jlj6K3H8VQc").worksheets[0]

# Gets content of A2 cell.
#p ws[2, 1]  #==> "hoge"

# Changes content of cells.
# Changes are not sent to the server until you call ws.save().

x = 1
$my_hash.each do |key, value|
	ws[x, 1] = key
	ws[x, 2] = value
	x +=1
end
ws.save

# Dumps all cells.
(1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    p ws[row, col]
  end
end

# Yet another way to do so.
p ws.rows  #==> [["fuga", ""], ["foo", "bar]]

# Reloads the worksheet to get changes by other clients.
ws.reload
end
save_as_spreadsheet






