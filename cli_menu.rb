require 'json'
require 'pp'
require './constants.rb'
require './searchcli/search.rb'

def main_menu
  puts "\n"
  puts "\t Select search options:"
  puts "\t * Press 1 to search Zendesk"
  puts "\t * Press 2 to view a list of searchable fields"
  puts "\t * Type 'quit' to exit"
end

def cli_options
  run = true
  main_menu
  until !run
    command = gets.chomp
    case command
    when '1'
      puts RESOURCE_SELECTION_MESSAGE
      run = perform_search
    when '2'
      VALID_SEARCH_OPTIONS.each do |op|
        puts '-------------------------------------'
        puts "Search for #{OBJECT_MAP[op].camelize} with"
        VALID_SEARCH_FIELDS[op].each do |f|
          puts "#{f} \n"
        end
        puts "\n"
      end
      main_menu
    when QUIT_COMMAND
      run = invalid_and_exit
    else
      main_menu
      run = true
    end
  end
end

def perform_search
  option = gets.chomp.to_s
  if option == QUIT_COMMAND
    return false
  elsif VALID_SEARCH_OPTIONS.include? option
    puts SEARCH_FIELD_MESSAGE
    field = gets.chomp.to_s.strip
    if VALID_SEARCH_FIELDS[option].include? field
      puts SEARCH_VALUE_MESSAGE
      value = gets.chomp
      search = SearchCli::Search.new
      result = search.search(OBJECT_MAP[option], field, value)
      puts result.empty? ? NO_RESULTS_MESSAGE : JSON.pretty_generate(result)
      main_menu
      return true
    else
      return invalid_and_exit
    end
  else
    return invalid_and_exit
  end
end

def invalid_and_exit
  puts INVALID_SELECTION_MESSAGE
  return false
end
