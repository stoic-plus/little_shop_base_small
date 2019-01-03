class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_save :generate_slug

  private

  def generate_slug
    return false unless self.class == Item
    self.slug = "#{name.downcase.gsub(" ", "-")}#{SecureRandom.hex(3)}" if name
  end
end
