module Model
  # user class, for organization's users. Belongs to an organization.
  class User < ApplicationRecord
    serialize :tags # tags is an array, this will saved and retrieve as an array
    belongs_to :organization
    def tickets
      user_tickets = Ticket.where('submitter_id = ? OR assignee_id = ?', id, id)
      user_tickets
    end
  end
end
