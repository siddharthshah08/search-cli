# Instead of loading all of Rails, load the
# particular Rails dependencies we need
require 'sqlite3'
require 'active_record'
require './cli_menu.rb'
require './searchcli/application_record.rb'
require './searchcli/user.rb'
require './searchcli/organization.rb'
require './searchcli/ticket.rb'
RESOURCE_DIR = './resources'.freeze
      # Set up a database that resides in RAM
      ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: ':memory:'
      )

    # Set up database tables and columns
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define do
      create_table 'users', force: :cascade do |t|
        t.integer  '_id'
        t.text     'url'
        t.text     'external_id'
        t.text     'name'
        t.text     'alias'
        t.text     'created_at'
        t.boolean  'active'
        t.boolean  'verified'
        t.boolean  'shared'
        t.text     'locale'
        t.text     'timezone'
        t.text     'last_login_at'
        t.text     'email'
        t.text     'phone'
        t.text     'signature'
        t.integer  'organization_id'
        t.text     'tags'
        t.boolean  'suspended'
        t.text     'role'
      end
      create_table 'tickets', force: :cascade do |t|
        t.text     '_id'
        t.text     'external_id'
        t.text     'url'
        t.text     'external_id'
        t.text     'created_at'
        # renamed it to 'ticket_type' as 'type' is reserved for
        # storing the class of singel-table inheritance
        t.text     'ticket_type'
        t.text     'subject'
        t.text     'description'
        t.text     'priority'
        t.text     'status'
        t.integer  'submitter_id'
        t.integer  'assignee_id'
        t.integer  'organization_id'
        t.text     'tags'
        t.boolean  'has_incidents'
        t.text     'due_at'
        t.text     'via'
      end
      create_table 'organizations', force: :cascade do |t|
        t.integer  '_id'
        t.text     'external_id'
        t.text     'url'
        t.text     'name'
        t.text     'domain_names'
        t.text     'created_at'
        t.text     'details'
        t.boolean  'shared_tickets'
        t.text     'tags'
      end
    end

    users = JSON.parse(File.read("#{RESOURCE_DIR}/users.json"))
    tickets = JSON.parse(File.read("#{RESOURCE_DIR}/tickets.json"))
    organizations = JSON.parse(File.read("#{RESOURCE_DIR}/organizations.json"))

    users.each do |user|
      u = SearchCli::User.create(user)
      # Overwrite _id field values into
      # ActiveRecord default primary key column id
      u.id = u['_id']
      u.save
    end
    tickets.each do |ticket|
      type = ticket['type']
      # the column type is reserved for storing the
      # class in case of singel-table inheritance
      ticket.delete('type')
      t = SearchCli::Ticket.create(ticket)
      t.ticket_type = type
      t.save
    end
    organizations.each do |organization|
      org = SearchCli::Organization.create(organization)
      # Overwrite _id field values into
      # ActiveRecord default priamry key column id
      org.id = org['_id']
      org.save
    end
    puts "Welcome to Zendesk Search \n"
    puts "Type 'quit' to exit at any time, Press 'Enter' to continue \n"
    begin
      run = true
      while run
        command = gets
        case command
        when "\n", "\r" # Enter key
          run = false
          cli_options
        when 'quit'
          run = false
          return
        else # anything other than 'Enter'
          puts "Please press 'Enter' key or type 'quit'"
        end
      end
    rescue StandardError, SystemExit, Interrupt => e
      puts "Exiting #{e.inspect}"
    end
