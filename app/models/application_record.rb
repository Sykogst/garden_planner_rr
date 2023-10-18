class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Will need to add some tests here, but dont put this here
  # Too much inheriting going on
  # Only if valid EVERYWHER
  def self.search_by(params)
    where('lower(name) like ?', "%#{params.downcase}%")
  end
end
