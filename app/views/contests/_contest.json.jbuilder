json.extract! contest, :id, :name, :image, :url, :start, :end, :reward, :created_at, :updated_at
json.url contest_url(contest, format: :json)