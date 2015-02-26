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
        # @html.search("cite").each do |cite| 
        # results << cite.inner_text 
        # end 

        # @html_two.search("cite").each do |cite| 
        # results << cite.inner_text 
        # end 
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
          @results = results_pass_seven

          # Take the results array
          result_group = []
          @results.each do |r|
            result_group << URI.encode(r.gsub(" ", ""))
            @result_group = result_group.uniq
          end

          alchemyapi = AlchemyAPI.new()
          parser_key_token = "e7bc27e0bdf47322e153753e80eb446381184dba"
          @document_results = []
          @sentiment_results = []

          # @result_group = ["http://www.laweekly.com/restaurants/jonathan-gold-reviews-guisados-2172029", "http://www.google.com", "http://www.google.com"]

          @result_group.each do |i|
            resp = HTTParty.get("http://www.readability.com/api/content/v1/parser?url=#{i}/&token=#{parser_key_token}")
            # resp = resp.delete_if {|x| x =~ /invalid/}
            @document_results << resp.parsed_response
            @document_results.delete_if {|x| x =~ /invalid/}
            # need to remove error messages either with reject or hash
          # @document_results.zip(alchemyapi.sentiment_targeted('url', i, @name))
          # @new_results = @document_results | @sentiment_results
          end

          @url_group = []

          @document_results.each do |i|
            @url_group << i["url"]
          end

          # Loop through the document_results array and add the sentiment results to the end of each
          # individual object, for each object add the sentiment result into the object
          #[ {name: "Jim", email: "Jimbo@gmail.com"}]

            # parse the urls with this code
            # content = @document_results['content']
            # @content = Nokogiri::HTML.parse(content).css('p')[2].text

            # @excerpts = []
    
            # @result_group.each do |i|
            #   @excerpts << Nokogiri::HTML.parse(i).css('p')[2].text
            # end

            # CREATE NEW MASTER LIST FROM RESULTS

              alchemyapi = AlchemyAPI.new()
              @sentiment_results = []

              @url_group.each do |i|
                @sentiment_results << alchemyapi.sentiment_targeted('url', i, @name)
              end

              # @type = response['docSentiment']['type']
              # score = response['docSentiment']['score']
              # @score = score.to_f * 100

              @score_results = []
              @type_results = []

              @sentiment_results.each do |x|
                @score_results << x['docSentiment']['score'].to_f * 100
                @type_results << x['docSentiment']['type']
              end

              # Rails.logger.info(@score_results)
              # Assign the first score_result to the first object and so on and so forth
              # set up if else statement, if this then that

              @document_results[0][:docSentiment] = {score: @score_results[0], type: @type_results[0]}
                @document_results[1][:docSentiment] = {score: @score_results[1], type: @type_results[1]}
                  @document_results[2][:docSentiment] = {score: @score_results[2], type: @type_results[2]}
                    @document_results[3][:docSentiment] = {score: @score_results[3], type: @type_results[3]}
                      @document_results[4][:docSentiment] = {score: @score_results[4], type: @type_results[4]}

                      #   [1..10].each do 
                      # @document_results
  

            # @score_results.each do |x|    
              # @document_results.each do |d|              
              #    d[:docSentiment] = { score: @score_results } 
              #    # @score_results
              #    # Rails.logger.info(d[:docSentiment])
              #   end
              # # end

        render json: @document_results

  end

  # def sentiment
  #         @name = URI.encode(params[:name])
  #       # Need to add zipcode and/or adddress into search params below
  #       # restaurant review results
  #       page = open "http://www.google.com/search?q=restaurant+review+food+#{@name}"
  #       @html = Nokogiri::HTML page

  #       # blog review results
  #       blog = open "http://www.google.com/search?q=blog+review+#{@name}"
  #       @html_two = Nokogiri::HTML blog

  #       # Create empty array called results
  #       results = []
        
  #       #Pass the returned search result urls into an array called results
  #       # @html.search("cite").each do |cite| 
  #       # results << cite.inner_text 
  #       # end 

  #       # @html_two.search("cite").each do |cite| 
  #       # results << cite.inner_text 
  #       # end 
  #                     results << @html.css('#res h3 a')[0]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[1]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[2]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[3]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[4]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[5]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[6]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     results << @html.css('#res h3 a')[7]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     # results << @html.css('#res h3 a')[8]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                     # results << @html.css('#res h3 a')[9]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                     

  #                      results << @html_two.css('#res h3 a')[0]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[1]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[2]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[3]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[4]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[5]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[6]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      results << @html_two.css('#res h3 a')[7]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      # results << @html_two.css('#res h3 a')[8]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
  #                      # results << @html_two.css('#res h3 a')[9]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
                  
             

  #         #Delete certain results from the array if they match words like "yelp", etc.
  #         # do multiple strips for each offending phrase, urbanspoon, menupages, tripadvisor
  #         results_pass_one = results.delete_if {|x| x =~ /yelp/ }
  #         results_pass_two = results_pass_one.delete_if {|x| x =~ /urbanspoon/ }
  #         results_pass_three = results_pass_two.delete_if {|x| x =~ /menupages/}
  #         results_pass_four = results_pass_three.delete_if {|x| x =~ /tripadvisor/}
  #         results_pass_five = results_pass_four.delete_if {|x| x =~ /images/}
  #         results_pass_six = results_pass_five.delete_if {|x| x =~ /zagat/}
  #         results_pass_seven = results_pass_six.delete_if {|x| x =~ /opentable/}
  #         @results = results_pass_seven

  #         # Take the results array
  #         result_group = []
  #         @results.each do |r|
  #           result_group << URI.encode(r.gsub(" ", ""))
  #           @result_group = result_group.uniq
  #         end

  #         alchemyapi = AlchemyAPI.new()
  #             @sentiment_results = []

  #             @result_group.each do |i|
  #               @sentiment_results << alchemyapi.sentiment_targeted('url', i, @name)
  #             end

  #             @score_results = []

  #             @sentiment_results.each do |x|
  #               @score_results << x['docSentiment']['score']
  #               @score_results.delete_if {|x| x =~ /null/}
  #             end

  #             # @type = response['docSentiment']['type']
  #             # score = response['docSentiment']['score']
  #             # @score = score.to_f * 100

  #       render json: @sentiment_results

  # end

  end

end