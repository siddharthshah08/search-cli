VALID_SEARCH_OPTIONS = %w[1 2 3].freeze
VALID_SEARCH_FIELDS = {
  '1' => %w[_id url external_id name alias created_at active verified shared
            locale timezone last_login_at email phone signature
            organization_id tags suspended role],
  '2' => %w[_id url external_id created_at ticket_type subject description
            priority status submitter_id assignee_id organization_id tags
            has_incidents due_at via],
  '3' => %w[_id url external_id name domain_names created_at details
            shared_tickets tags]
}.freeze
OBJECT_MAP = { '1' => 'users', '2' => 'tickets', '3' => 'organizations' }.freeze
QUIT_COMMAND = 'quit'.freeze
RESOURCE_SELECTION_MESSAGE = 'Select 1) Users or 2) Tickets or '\
                              '3) Organization for searching'.freeze
INVALID_SELECTION_MESSAGE = 'Invalid input'.freeze
SEARCH_FIELD_MESSAGE = 'Enter search field'.freeze
SEARCH_VALUE_MESSAGE = 'Enter search value'.freeze
NO_RESULTS_MESSAGE = 'No results found'.freeze
