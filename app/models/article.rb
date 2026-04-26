# Represents an encyclopedia article with title, content, author, and date.
class Article < ApplicationRecord
  # Searches for articles by title or content.
  #
  # @param query [String] the search term
  # @return [ActiveRecord::Relation] the matching articles or all articles if query is blank
  def self.search(query)
    if query.present?
      # Case-insensitive search using SQL LIKE
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
