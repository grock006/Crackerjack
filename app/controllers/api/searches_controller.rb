module Api
  class SearchesController < ApplicationController
    require 'nokogiri'
    require 'open-uri'
    require 'uri'

  # def index
  
  #       def search(name)
  #       client = Instagram.client
  #       result = client.user_search(name)
  #       return result
  #       end

  #       @result = search(params[:name])[0]
  #       render json: @result
  
  # end


  # def show
  #       client = Instagram.client
  #       result = client.user_search(params[:name])[0]
  #       id = result.id 
  #       @result = client.user_recent_media(id).take(8)
  #       render json: @result
  # end

  def review
        @name = URI.encode(params[:name])
        # Need to add zipcode and/or adddress into search params below
        # restaurant review results
        page = open "http://www.google.com/search?q=restaurant+review+food+#{@name}"
        @html = Nokogiri::HTML page

        # blog review results
        blog = open "http://www.google.com/search?q=blog+review+#{@name}"
        @html_two = Nokogiri::HTML blog

        # Create empty array called results
        results = []
        
        #Pass the returned search result urls into an array called results
        # Create a for loop to pass the results count into a results array
      
                      results << @html.css('#res h3 a')[0]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[1]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[2]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[3]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[4]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[5]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[6]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      results << @html.css('#res h3 a')[7]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      # results << @html.css('#res h3 a')[8]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                      # results << @html.css('#res h3 a')[9]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                     

                       results << @html_two.css('#res h3 a')[0]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[1]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[2]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[3]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[4]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[5]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[6]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       results << @html_two.css('#res h3 a')[7]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       # results << @html_two.css('#res h3 a')[8]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                       # results << @html_two.css('#res h3 a')[9]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                  
             

          #Delete certain results from the array if they match words like "yelp", etc.
          # do multiple strips for each offending phrase, urbanspoon, menupages, tripadvisor
          results_pass_one = results.delete_if {|x| x =~ /yelp/ }
          results_pass_two = results_pass_one.delete_if {|x| x =~ /urbanspoon/ }
          results_pass_three = results_pass_two.delete_if {|x| x =~ /menupages/}
          results_pass_four = results_pass_three.delete_if {|x| x =~ /tripadvisor/}
          results_pass_five = results_pass_four.delete_if {|x| x =~ /images/}
          results_pass_six = results_pass_five.delete_if {|x| x =~ /zagat/}
          results_pass_seven = results_pass_six.delete_if {|x| x =~ /opentable/}
          results_pass_eight = results_pass_seven.delete_if {|x| x =~ /list/}
          @results = results_pass_eight

          # Take the results array
          result_group = []
          @results.each do |r|
            result_group << URI.encode(r.gsub(" ", ""))
            @result_group = result_group.uniq
          end

          # Sentiment Analysis Key and Token
          alchemyapi = AlchemyAPI.new()
          parser_key_token = "e7bc27e0bdf47322e153753e80eb446381184dba"
          @document_results = []
          @sentiment_results = []

          # @result_group = ["http://www.laweekly.com/restaurants/jonathan-gold-reviews-guisados-2172029", "http://www.google.com", "http://www.google.com"]
          http_threads = []
          @result_group.each do |i|
            http_threads << Thread.new {
              resp = HTTParty.get("http://www.readability.com/api/content/v1/parser?url=#{i}/&token=#{parser_key_token}")
              @document_results << resp.parsed_response
              #Remove error messages from Readability API response
              @document_results.delete_if {|x| x =~ /invalid/}
            }
          end
          http_threads.each {|t| t.join }
          
          # Pass the new results into a url group
          @url_group = []
          @document_results.each do |i|
            @url_group << i["url"]
          end

            # CREATE NEW MASTER LIST FROM RESULTS

              alchemyapi = AlchemyAPI.new()
              @sentiment_results = []
              threads = []
              @url_group.each do |i|
                threads << Thread.new {
                  @sentiment_results << alchemyapi.sentiment_targeted('url', i, @name)
                }
                # @sentiment_results << resp.parsed_response
                 # @sentiment_results.delete_if {|x| x =~ /ERROR/}
              end
              threads.each { |t| t.join }

               @score_results = []
                @type_results = []

              @sentiment_results.each do |x|
                @score_results << x['docSentiment']['score'].to_f * 100 + 70 if x['docSentiment'] && x['docSentiment']['score']
                @type_results << x['docSentiment']['type'] if x['docSentiment'] && x['docSentiment']['type']
              end

              @scores = []
              @score_results.each do |x|
                 @scores << x.to_i 
              end

              @url_count = @url_group.count

              @test = @scores.inject{|sum,x| sum + x }
              @average = @test / @url_count

              # attempt to add content to document results
              # content = @document_results['content']
              # @content = Nokogiri::HTML.parse(content).css('p')[2].text

              # @content = []
              # @document_results.each do |x|
              #   @content << x['content'] if x['content']
              #   # @content << Nokogiri::HTML.parse(@content)
              # end  

              # @test = []
              # @content.each do |x|
              #   @test << Nokogiri::HTML.parse(x).css('p')[4].text if Nokogiri::HTML.parse(x).css('p')[4].text
              # end



              (0...@url_count).each do |i|
                  @document_results[i][:docSentiment] = {
                    score: @score_results[i], 
                    type: @type_results[i],
                    totalAverage: @average
                  }
                  # Rails.logger.info(i)
              end

              # Rails.logger.info(@score_results)
  
  


        render json: @document_results

    end

  end

end