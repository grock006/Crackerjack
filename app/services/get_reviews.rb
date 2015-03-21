class GetReviews
	require 'nokogiri'
    require 'open-uri'
    require 'uri'

		def self.call(name, location)

				@name = URI.encode(name)
		        @name_clean = (name)

		        @location = URI.encode(location)
		        @location_clean = (location)

				# Open the google search results with Nokogiri
			   	page = open "http://www.google.com/search?q=restaurant+review+food+#{@name}+#{@location}"
		        @html = Nokogiri::HTML page

		        # Grab restaurant 'blog' review results
		        blog = open "http://www.google.com/search?q=blog+review+#{@name}+#{@location}"
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
		                 

		                       results << @html_two.css('#res h3 a')[0]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[1]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[2]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[3]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[4]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[5]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[6]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                       results << @html_two.css('#res h3 a')[7]["href"].gsub("/url?q=","").gsub(/&sa(.*)/,"")
		                               
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
		          results_pass_nine = results_pass_eight.delete_if {|x| x =~ /gayot/}
		          results_pass_ten = results_pass_nine.delete_if {|x| x =~ /google/}
		          results_pass_eleven = results_pass_ten.delete_if {|x| x =~ /tastemade/}
		          results_pass_twelve = results_pass_eleven.delete_if {|x| x =~ /yellowpages/}
		          @results = results_pass_twelve

		          # Take the results array
		          result_group = []
		          @results.each do |r|
		            result_group << URI.encode(r.gsub(" ", ""))
		            @result_group = result_group.uniq
		          end

		          # Sentiment Analysis Key and Token
		          alchemyapi = AlchemyAPI.new()
		
		          @document_results = []
		          @sentiment_results = []

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
		              @keyword_results = []
		              threads = []
		              @url_group.each do |i|
		                threads << Thread.new {
		                  @sentiment_results << alchemyapi.sentiment('url', i)
		                  @keyword_results << alchemyapi.keywords('url', i)
		                }
		              end
		              threads.each { |t| t.join }

		              # Create array for score results and type results
		              @score_results = []
		              @type_results = []
		              @sentiment_results.each do |x|
		                @score_results << x['docSentiment']['score'].to_f * 100 + 50 if x['docSentiment'] && x['docSentiment']['score']
		                @type_results << x['docSentiment']['type'] if x['docSentiment'] && x['docSentiment']['type']
		              end

		              # 
		              @postive_total = 0
		              @negative_total = 0
		              @sentiment_results.each do |x|
		                if x['docSentiment'] && x['docSentiment']['score'] 
		                  if x['docSentiment']['score'].to_f * 100 + 50 > 70 && (x['docSentiment']['type'] == "positive" || x['docSentiment']['type'] == "neutral" || x['docSentiment']['type'] == nil)
		                    @postive_total += 1
		                  else
		                    @negative_total += 1  
		                  end                                    
		                end
		              end

		              # Keywords
		              @keywords = []
		              @keyword_results.each do |x|
		                @keywords << x['keywords']
		              end

		              # Array of all scores
		              @scores = []
		              @score_results.each do |x|
		                 @scores << x.to_i 
		              end
		            
		              @url_count = @url_group.count if @url_group.count > 0 
		            

		              @score_total = @scores.inject{|sum,x| sum + x }

		              if @score_total != nil && @scores.count != nil
		                @average = @score_total / @scores.count
		              else
		                @average = ":( Sorry, Not Enough Information to Analyze Reviews"
		              end

		              @content = []
		              @document_results.each do |x|
		                @content << x['content'] if x['content']
		              end 

		              nokogiri_threads = []
		              @content_results = []
		              @content.each do |x|
		                nokogiri_threads << Thread.new {
		                    if Nokogiri::HTML.parse(x).css('p')[2] != nil && Nokogiri::HTML.parse(x).css('p')[3] != nil
		                      @content_results << Nokogiri::HTML.parse(x).css('p')[2].text + Nokogiri::HTML.parse(x).css('p')[3].text
		                      # add another paragraph 
		                    elsif Nokogiri::HTML.parse(x).css('p')[1] != nil && Nokogiri::HTML.parse(x).css('p')[2] != nil
		                      @content_results << Nokogiri::HTML.parse(x).css('p')[1].text + Nokogiri::HTML.parse(x).css('p')[2].text
		                    elsif Nokogiri::HTML.parse(x).css('p')[0] != nil && Nokogiri::HTML.parse(x).css('p')[1] != nil
		                      @content_results << Nokogiri::HTML.parse(x).css('p')[0].text + Nokogiri::HTML.parse(x).css('p')[1].text
		                    elsif Nokogiri::HTML.parse(x).css('p')[0] != nil 
		                      @content_results << Nokogiri::HTML.parse(x).css('p')[0].text
		                    else
		                      @content_results << x 
		                  end
		                }
		              end
		              nokogiri_threads.each { |t| t.join }

		              if @postive_total != nil && @url_count != nil
		              rating = ((@postive_total.to_f / @url_count.to_f) * 100) / 20
		              @rating = rating.to_f
		              end

		              if @content_results[0] != nil && @url_count != nil 
		              Restaurant.create(name: @name_clean, location: @location_clean, content: @content_results[0], total_reviews: @url_count, positive_reviews: @postive_total, negative_reviews: @negative_total, rating: @rating)
		              end

		              if @url_count != nil && @url_count > 0
		                (0...@url_count).each do |i|
		                    @document_results[i][:docSentiment] = {
		                      score: @scores[i], 
		                      type: @type_results[i],
		                      totalAverage: @average,
		                      contentExcerpt: @content_results[i],
		                      keywords: @keywords[i],
		                      total_review: @url_count,
		                      pos_total: @postive_total,
		                      neg_total: @negative_total
		                    }
		                end
		              end

		              return @document_results
		  
		end

private		

		def self.parser_key_token
			Figaro.env.parser_key_token
		end

end