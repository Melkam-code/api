module JsonApiHelpers
  def json
    JSON.parse(response.body)
  end

  def json_data
    json["articles"]
  end
end
