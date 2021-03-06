module JsonParserHelper
  def parsed_json(key=nil)
    key ? JSON.parse(body)[key] : JSON.parse(body)
  end

  def body
    response.body
  end

  def status
    response.status
  end
end


RSpec.configure do |config|
  config.include JsonParserHelper, type: :controller
  config.include JsonParserHelper, type: :request
end
