module Api
  class SearchesController < ApplicationController
    require 'nokogiri'
    require 'open-uri'
    require 'uri'

  def index
  
        def search(name)
        client = Instagram.client
        result = client.user_search(name)
        return result
        end

        @result = search(params[:name])[0]
        render json: @result
  
  end


  def show
        client = Instagram.client
        result = client.user_search(params[:name])[0]
        id = result.id 
        @result = client.user_recent_media(id).take(8)
        render json: @result
  end

  def review
        @name = URI.encode(params[:name])
        
        # restaurant review results
        page = open "http://www.google.com/search?q=restaurant+review+#{@name}"
        @html = Nokogiri::HTML page

        # blog review results
        blog = open "http://www.google.com/search?q=blog+review+#{@name}"
        @html_two = Nokogiri::HTML blog

        # Create empty array called results
        results = []
        
        #Pass the returned search result urls into an array called results
        @html.search("cite").each do |cite| 
        results << cite.inner_text 
        end 

        @html_two.search("cite").each do |cite| 
        results << cite.inner_text 
        end 


          #Delete certain results from the array if they match words like "yelp", etc.
          # do multiple strips for each offending phrase, urbanspoon, menupages, tripadvisor
          results_pass_one = results.delete_if {|x| x =~ /yelp/ }
          results_pass_two = results_pass_one.delete_if {|x| x =~ /urbanspoon/ }
          results_pass_three = results_pass_two.delete_if {|x| x =~ /menupages/}
          results_pass_four = results_pass_three.delete_if {|x| x =~ /tripadvisor/}
          results_pass_five = results_pass_four.delete_if {|x| x =~ /https/}
          @results = results_pass_five

          # Take the results array
          result_group = []
          @results.each do |r|
            result_group << URI.encode("http://" + r.gsub(" ", ""))
            @result_group = result_group
          end


          parser_key_token = "e7bc27e0bdf47322e153753e80eb446381184dba"
          @document_results = []

          @result_group.each do |i|
          @document_results << HTTParty.get("http://www.readability.com/api/content/v1/parser?url=#{i}/&token=#{parser_key_token}")
          end

        render json: @result_group 
        # @document_results

  end

  end

end