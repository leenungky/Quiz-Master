json.array!(@posts) do |post|
  json.extract! post, :id, :question, :answer
  json.url post_url(post, format: :json)
end
