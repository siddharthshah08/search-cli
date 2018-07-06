module SearchCli
  # Search class, houses search method
  class Search
    # the code below can be DRYed, but since there are custom fields and
    # attributes like get name in case of organization, submitter and
    # assignee while subject for tickets. ActiveRecord serializer can be
    #  used to define what all fields can be returned in a response.

    def search(res, field, value)
      begin
        # SQLite stores true as 't' and false as 'f'
        # so we need to change the value
        value = 't' if value == 'true'
        value = 'f' if value == 'false'
        result = []
        case res
        when 'users'
          records = User.where("#{field} = ? ", value)
          records.each do |record|
            sub_object = {
              'organization_name' =>
                  record.organization.nil? ? '-' : record.organization.name,
              'tickets' => record.tickets.map(&:subject) || []
            }
            merged = record.attributes.merge sub_object
            merged.delete('id')
            result << merged
          end
        when 'tickets'
          records = Ticket.where("#{field} = ? ", value)
          records.each do |record|
            sub_object = {
              'submitter' => record.submitter.nil? ? '-' : record.submitter.name,
              'assignee' => record.assignee.nil? ? '-' : record.assignee.name,
              'organization_name' =>
                  record.organization.nil? ? '-' : record.organization.name
            }
            merged = record.attributes.merge sub_object
            merged.delete('id')
            result << merged
          end
        when 'organizations'
          records = Organization.where("#{field} = ? ", value)
          records.each do |record|
            sub_object = {
              'users' => record.users.map(&:name),
              'tickets' => record.tickets.map(&:subject)
            }
            merged = record.attributes.merge sub_object
            merged.delete('id')
            result << merged
          end
        end
        result
      rescue StandardError => e
        puts "Search failed : #{e.inspect}"
        return []
      rescue ActiveRecord::StatementInvalid => invalid
        puts "Invalid search : #{invalid.inspect}"
        return []
      end
    end
  end
end
