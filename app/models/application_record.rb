class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_save :generate_slug

  private

  def generate_slug
    return false unless self.class == Item || self.class == User
    self.slug = "#{id}-#{name.parameterize}" if name && self.class == Item
    self.slug = email.parameterize if name && self.class == User
  end
end
