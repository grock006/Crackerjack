require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = "Xnvaip0-eY6FzwXXgS-Ctw"
  config.consumer_secret = "T7KBu97EJk9acSbMSe3j1Z5F46c"
  config.token = "bSIXuYiiYZWLx7cPiYfQQYB5LCP49ps8"
  config.token_secret = "SBQtXi682Ce-niYRmGR2jNkqCAA"
end

 # yelp = Yelp::Client.new({ consumer_key: "Xnvaip0-eY6FzwXXgS-Ctw",
      #                        consumer_secret: "T7KBu97EJk9acSbMSe3j1Z5F46c",
      #                        token: "bSIXuYiiYZWLx7cPiYfQQYB5LCP49ps8",
      #                        token_secret: "SBQtXi682Ce-niYRmGR2jNkqCAA"
      #                      })                       