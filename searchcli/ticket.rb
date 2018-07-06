module SearchCli
  # ticket class, for organization's tickets. Belongs to an organization
  # sigle-table inheritance as submitter and assignee are both types of users
  class Ticket < ApplicationRecord
    serialize :tags # tags is an array, this will saved and retrieve as an array
    alias_attribute :requester_id, :submitter_id
    belongs_to :organization
    belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id'
    belongs_to :submitter, class_name: 'User', foreign_key: 'submitter_id'
  end
end
