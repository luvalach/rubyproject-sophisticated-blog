json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :body, :approved, :commentable_id, :commentable_type
  json.url comment_url(comment, format: :json)
end
