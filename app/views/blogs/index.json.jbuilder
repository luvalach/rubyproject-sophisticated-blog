json.array!(@blogs) do |blog|
  json.extract! blog, :id, :name, :user_id
  json.url blog_url(blog, format: :json)
end
