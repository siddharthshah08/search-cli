module Model
  # Search class, houses search method
  class Search
    def search(res, field, value)
      result = []
      case res
      when 'users'
        records = User.where("#{field} = ? ", value)
        records.each do |record|
          sub_object = {
            'organization_name' => record.organization.name,
            'tickets' => record.tickets.map(&:subject) || []
          }
          merged = record.attributes.merge sub_object
          result << merged
        end
      when 'tickets'
        records = Ticket.where("#{field} = ? ", value)
        records.each do |record|
          sub_object = {
            'submitter' => record.submitter.nil? ? '-' : record.submitter.name,
            'assignee' => record.assignee.nil? ? '-' : record.assignee.name,
            'organization_name' => record.organization.nil? ? '-' : record.organization.name
          }
          merged = record.attributes.merge sub_object
          result << merged
        end
      when 'organizations'
        records = Organization.where("#{field} = ? ", value)
        records.each do |record|
          sub_object = {
            'users' => record.users.map { |u| { 'name' => u.name } },
            'tickets' => record.tickets.map { |t| { 'subject' => t.subject } }
          }
          merged = record.attributes.merge sub_object
          result << merged
        end
      end
      result
    end
  end
end
