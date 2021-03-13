module PagesHelper
  def search_query(hash)
    hash.try(:reject) { |_k, v| v.blank? }.try(:each) do |_key, value|
      return value
    end
  end
end
