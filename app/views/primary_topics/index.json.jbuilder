json.array!(@primary_topics) do |primary_topic|
  json.extract! primary_topic, :name
  json.url primary_topic_url(primary_topic, format: :json)
end