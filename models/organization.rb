module Model
  # ticket class, for organization's tickets. Has many tickets and users.
  class Organization < ApplicationRecord
    serialize :tags # tags is an array, this will saved and retrieve as an array
    serialize :domain_names # similar approach as tags above.
    has_many :tickets
    has_many :users
  end
end
