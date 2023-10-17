class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.search_by(params)
    where('lower(name) like ?', "%#{params.downcase}%")
  end
end
