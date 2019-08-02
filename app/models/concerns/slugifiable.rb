module Slugifiable

  module InstanceMethods
    # Strip special characters and replace with "-"
    def slug 
      name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      # name.parameterize
    end
  end

  module ClassMethods
    # Return object from database based on slug
    def find_by_slug(slug)
      # Deslug
      # name = slug.split("-").collect{|w| w.capitalize}.join(" ")
      name = slug.gsub('-', ' ')

      # Find in database
      where('lower(name)=?', name).first
    end
  end

end