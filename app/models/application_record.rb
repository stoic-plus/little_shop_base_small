class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_save :generate_slug

  private

  def generate_slug
    return false unless self.class == Item || self.class == User

    self.slug = email.parameterize.gsub("_", "-") if self.class == User
    self.slug = name.parameterize if self.class == Item
  end
end
