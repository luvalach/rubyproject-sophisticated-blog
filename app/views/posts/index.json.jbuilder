json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :user_id, :blog_id, :can_be_commented, :comments_needs_approval
  json.url post_url(post, format: :json)
end
