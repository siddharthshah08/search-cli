# Instead of loading all of Rails, load the
# particular Rails dependencies we need
load './models/application_record.rb'
require './models/user.rb'
require './models/organization.rb'
require './models/ticket.rb'
require 'sqlite3'
require 'active_record'
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
      t.text     'ticket_type' #renamed it to 'ticket_type' as 'type' is reserved for storing the class of singel-table inheritance
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
RESOURCE_DIR = './data'
users = JSON.parse(File.read("#{RESOURCE_DIR}/users.json"))
tickets = JSON.parse(File.read("#{RESOURCE_DIR}/tickets.json"))
organizations = JSON.parse(File.read("#{RESOURCE_DIR}/organizations.json"))

puts "organizations : #{organizations}"

users.each { |user|
  u = Model::User.create(user)
  u.id = u['_id'] # Overwrite “_id” field values into ActiveRecord default priamry key column id
  u.save
}
tickets.each { |ticket|
  type = ticket['type']
  ticket.delete('type') # the column 'type' is reserved for storing the class in case of singel-table inheritance
  t = Model::Ticket.create(ticket)
  t.ticket_type = type
  t.save
}
organizations.each { |organization|
  org = Model::Organization.create(organization)
  org.id = org['_id'] # Overwrite “_id” field values into ActiveRecord default priamry key column id
  org.save
}
