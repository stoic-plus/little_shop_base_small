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
      last_match = Item.where("slug LIKE ?", "%#{slug}").last
      if last_match.slug == found_item.slug
        return "1-#{slug}"
      else
        return "#{last_match.slug[0].to_i + 1}#{last_match.slug[1..-1]}"
      end
    else
      return slug
    end
  end
end
