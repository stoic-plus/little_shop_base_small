class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_save :generate_slug

  private

  def generate_slug
    return false unless self.class == Item || self.class == User

    if self.class == User
      self.slug = email.parameterize.gsub("_", "-") if email
    else
      slug = name.parameterize
      self.slug = check_for_existing_slug(slug)
    end
  end

  def check_for_existing_slug(slug)
    found_item = Item.find_by(slug: slug)
    return slug if found_item == self

    if found_item
      if found_item.slug[0] =~ /\d/
        return "#{found_item.slug[0].to_i + 1}#{found_item.slug[1..-1]}"
      else
        return "1-#{slug}"
      end
    else
      return slug
    end
  end
end
