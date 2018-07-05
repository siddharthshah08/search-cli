VALID_SEARCH_OPTIONS = %w[1 2 3].freeze
VALID_SEARCH_FIELDS = {
  '1' => %w[_id url external_id name alias created_at active verified shared locale
    timezone last_login_at email phone signature organization_id tags suspended role],
  '2' => %w[_id url external_id created_at ticket_type subject description priority status submitter_id
    assignee_id organization_id tags has_incidents due_at via requester_id],
  '3' => %w[_id url external_id name domain_names created_at details shared_tickets tags]
}.freeze
OBJECT_MAP = { '1' => 'users', '2' => 'tickets', '3' => 'organizations' }.freeze
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
def cli_options
  run = true
  display_menu
  until !run
    command = gets.chomp
    case command
    when '1'
      puts 'Select 1) Users or 2) Tickets or 3) Organization'
        valid_option = false
        while !valid_option
          option = gets.chomp.to_s
          if option == 'quit'
            valid_option = true
            run = false
          elsif VALID_SEARCH_OPTIONS.include? option
            valid_option = true
            puts 'Enter search field'
            field = gets.chomp.to_s
            if VALID_SEARCH_FIELDS[option].include? field
              puts 'Enter search value'
              value = gets.chomp
              search = Model::Search.new
              result = search.search(OBJECT_MAP[option], field, value)
              if result.empty?
                puts 'No results found'
                display_menu
              else
                pp result
                display_menu
              end
            end
          else
            puts 'Invalid option'
            puts 'Select 1) Users or 2) Tickets or 3) Organization'
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
    when 'quit'
      run = false
      return
    else
      display_menu
      run = true
    end
  end
end
