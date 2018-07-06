require 'active_record'
module SearchCli
  # application_record base class
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
