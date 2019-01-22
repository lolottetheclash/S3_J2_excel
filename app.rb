require 'bundler'
require 'csv'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)


require 'app/scrapper'
page_mairie = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html")
puts page_mairie.mairies

