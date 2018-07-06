# SearchCli

Command line application with capability to search attribute values of chosen resource.

### Prerequisites
1. ruby (version >= 2.3.3)
### Installing and starting the interface
1. Download the project directory.
2. cd into the project `cd search-cli`
3. Install all the required gem files for the application using the command `bundle install ` on the command line.
4. run `ruby runner.rb` command to start the application.
5. The standard output should show the following
```
Welcome to Zendesk Search
Type 'quit' to exit at any time, Press 'Enter' to continue
```

### Running the interface
1. First message that you see on the screen is
```
Welcome to Zendesk Search
Type 'quit' to exit at any time, Press 'Enter' to continue
```
Anything other than typing `'quit'` or pressing the `Enter` will result in displaying of the same message.
2. When you press `Enter`, you should see the following
```
      Select search options:
	 * Press 1 to search Zendesk
	 * Press 2 to view a list of searchable fields
	 * Type 'quit' to exit
```
3. Press `1` will further display the following options
```
Select 1) Users or 2) Tickets or 3) Organization for searching
```
Press `1` for `Users`, `2` for `Tickets` and `3` for `Organizations`

For example `1` is provided as input, following message is displayed
```
Enter search field
```
Enter `_id`

The interface will next ask about the value of the field

```
Enter search value
```
Enter `12`

Following output will be displayed

```
[
  {
    "_id": 12,
    "url": "http://initech.zendesk.com/api/v2/users/12.json",
    "external_id": "38899b1e-89ca-43e7-b039-e3c88525f0d2",
    "name": "Watkins Hammond",
    "alias": "Mr Sally",
    "created_at": "2016-07-21T12:26:16 -10:00",
    "active": false,
    "verified": false,
    "shared": false,
    "locale": "en-AU",
    "timezone": "United Kingdom",
    "last_login_at": "2012-12-29T07:59:56 -11:00",
    "email": "sallyhammond@flotonic.com",
    "phone": "8144-293-283",
    "signature": "Don't Worry Be Happy!",
    "organization_id": 110,
    "tags": [
      "Bonanza",
      "Balm",
      "Fulford",
      "Austinburg"
    ],
    "suspended": false,
    "role": "end-user",
    "organization_name": "Kindaloo",
    "tickets": [
      "A Drama in Cayman Islands",
      "A Catastrophe in Macau",
      "A Drama in Germany",
      "A Catastrophe in New Zealand",
      "A Drama in Mauritius",
      "A Nuisance in Namibia"
    ]
  }
]
```
Returns an array of object(s)
All the details of the user with `_id` as `12`. The output also shows the user's `organization_name` and `tickets` where the user is either a `submitter` or a `assignee`

Similarly, for `Organization's` output object on valid search include all the users (their names) that belong to the organization as well as tickets (their subjects) for the organization. These fields of the sub-objects, in this case `User` and `Ticket` can be added based on requirements.

```
[
  {
    "_id": 111,
    "external_id": "852e22ab-76dc-4d92-9a1d-02d3e04349cb",
    "url": "http://initech.zendesk.com/api/v2/organizations/111.json",
    "name": "Speedbolt",
    "domain_names": [
      "quintity.com",
      "radiantix.com",
      "enomen.com",
      "minga.com"
    ],
    "created_at": "2016-03-10T10:36:00 -11:00",
    "details": "Artisan",
    "shared_tickets": true,
    "tags": [
      "Sheppard",
      "Nunez",
      "Bartlett",
      "Giles"
    ],
    "users": [
      "Gallegos Armstrong"
    ],
    "tickets": [
      "A Nuisance in Equatorial Guinea",
      "A Problem in Denmark",
      "A Drama in Cocos (Keeling Islands)",
      "A Nuisance in Virgin Islands (US)",
      "A Catastrophe in Jamaica",
      "A Drama in Australia"
    ]
  }
]
```
And final the output of a `Ticket` search if as follows. Contains the submitter and assignee name as well as organization's name.

```
[
  {
    "_id": "25c518a8-4bd9-435a-9442-db4202ec1da4",
    "external_id": "ff8be0f9-8b86-406e-a110-9ba1ca839850",
    "url": "http://initech.zendesk.com/api/v2/tickets/25c518a8-4bd9-435a-9442-db4202ec1da4.json",
    "created_at": "2016-01-11T08:56:20 -11:00",
    "ticket_type": "problem",
    "subject": "A Drama in Iraq",
    "description": "Magna consequat cillum pariatur fugiat aliquip incididunt est velit ex ipsum. Sunt ullamco ea pariatur proident consectetur id anim.",
    "priority": "high",
    "status": "pending",
    "submitter_id": 60,
    "assignee_id": 72,
    "organization_id": 103,
    "tags": [
      "Utah",
      "Hawaii",
      "Alaska",
      "Maryland"
    ],
    "has_incidents": false,
    "due_at": "2016-08-21T10:41:42 -10:00",
    "via": "chat",
    "submitter": "Dennis Hopkins",
    "assignee": "Valentine Ashley",
    "organization_name": "Plasmos"
  }
]
```

In case the search does not result any results following message displays on the console.
```
No results found
```
Type `quit` or press `cntrl` + `c` anytime to terminate and exit the interface.

### Design
This cli has three classes as models
1. Organization
2. User
3. Ticket
And they are related with following activerecord associations

Organization - `has_many` users, `has_many` tickets
User - `belongs_to` an organization
Ticker - `belongs_to` an organization and has a `submitter` and `assignee` `user` (Single table inheritance on User table.)

The application starts by running the `runner.rb` file. This file creates the tables and loads data in the objects. `sqlite's` inmemory database is used as database for the application

```
ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: ':memory:'
  )
```

Everytime the application is run, the data is loaded in memory and is removed once its terminated.
`Activerecord` and in-memory `sqlite` are used for the purpose of this project to showcase model relations and to keep the application light weight without using `rails` and actual database.

### Assumptions and constraints
1. Each `User` and `Ticket` will belong to an single `Organization` and `_id` is primary key on all 3 objects.
2. Search is case sensitive
2. “_id” fields on the JSON files corresponds to actual id field no the database, hence while populating database, “_id” field values are given to active record’s primary key field id field.
3. Renamed `type` column as `ticket_type` for the `Ticket` attribute as `type` reserved for storing the class in case of single-table inheritance
4. Time stamps are considered as string for simplicity
5. Can search only with single string or a number. Cannot search with data structure e.g. Array like  ["Oklahoma", "Louisiana", "Massachusetts", "New York”]

### Built With
```
ruby - 2.3.3
sqlite - 3.6.16
```
