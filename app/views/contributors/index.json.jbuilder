json.array!(@contributors) do |contributor|
  json.extract! contributor, :id, :dataset_id, :user_id
  json.url contributor_url(contributor, format: :json)
end
