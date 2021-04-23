module PagesHelper
  def search_query(hash)
    hash&.reject { |_k, v| v.blank? }&.each do |_key, value|
      return value
    end
  end
end
