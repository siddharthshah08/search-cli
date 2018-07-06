VALID_SEARCH_OPTIONS = %w[1 2 3].freeze
VALID_SEARCH_FIELDS = {
  '1' => %w[_id url external_id name alias created_at active verified shared locale
    timezone last_login_at email phone signature organization_id tags suspended role],
  '2' => %w[_id url external_id created_at ticket_type subject description priority status submitter_id
    assignee_id organization_id tags has_incidents due_at via requester_id],
  '3' => %w[_id url external_id name domain_names created_at details shared_tickets tags]
}.freeze
OBJECT_MAP = { '1' => 'users', '2' => 'tickets', '3' => 'organizations' }.freeze
QUIT_COMMAND = 'quit'.freeze
require './models/search.rb'
require 'json'
require 'pp'


def display_menu
  puts "\n"
  puts "\t Select search options:"
  puts "\t * Press 1 to search Zendesk"
  puts "\t * Press 2 to view a list of searchable fields"
  puts "\t * Type 'quit' to exit"
end

def resource_selection
  return 'Select 1) Users or 2) Tickets or 3) Organization for searching'
end

def invalid_selection_prompt
  return 'Invalid option'
end

def search_field_prompt
  return 'Enter search field'
end

def search_value_prompt
  return 'Enter search value'
end

def no_results_alert
  return 'No results found'
end
def cli_options
  run = true
  display_menu
  until !run
    command = gets.chomp
    case command
    when '1'
        puts resource_selection
        valid_option = false
        while !valid_option
          option = gets.chomp.to_s
          if option == QUIT_COMMAND
            valid_option = true
            run = false
          elsif VALID_SEARCH_OPTIONS.include? option
            valid_option = true
            puts search_field_prompt
            field = gets.chomp.to_s
            if VALID_SEARCH_FIELDS[option].include? field
              puts search_value_prompt
              value = gets.chomp
              search = Model::Search.new
              result = search.search(OBJECT_MAP[option], field, value)
              if result.empty?
                puts no_results_alert
                display_menu
              else
                puts JSON.pretty_generate(result)
                display_menu
              end
            end
          else
            puts resource_selection
            puts invalid_selection_prompt
          end
        end
    when '2'
      VALID_SEARCH_OPTIONS.each do |option|
        puts "-------------------------------------"
        puts "Search for #{OBJECT_MAP[option].camelize} with"
        VALID_SEARCH_FIELDS[option].each do |field|
          puts "#{field} \n"
        end
        puts "\n"
      end
      display_menu
    when QUIT_COMMAND
      run = false
      return
    else
      display_menu
      run = true
    end
  end
end
