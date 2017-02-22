json.extract! voice, :id, :creation, :email, :name, :last_name, :done, :message, :source_url, :destination_url, :created_at, :updated_at
json.url voice_url(voice, format: :json)