#Crackerjack Project

###Restaurant Review Analysis Site in the style of "Rotten Tomatoes"

See online here: [Crackerjack](https://crackerjack-app.herokuapp.com/)

Crackerjack is a web application built with the intention of creating a “Rotten Tomatoes” style ranking system for restaurants. It uses the Nokogiri gem and Readability Parser API to scrape Google search results for restaurant reviews, and the Alchemy Sentiment Analysis API to analyze results for positive or negative content. 

##Data Source:

With each restaurant search, results for relevant publications and blog reviews are scraped from Google search pages using a custom Ruby scraper. The scraper was created specifically for this project using [Nokogiri](http://www.nokogiri.org/) combined with the [Readability Parser API](https://www.readability.com/developers/api/parser) to break the article into title, content, author, etc. 

Article content is passed through the [Alchemy Language API](http://www.alchemyapi.com/products/alchemylanguage/sentiment-analysis) which analyzes the text and returns a postive or negative "Sentiment Analysis," which is calculated together to give it a total scores, which is compared against the
Google Places and Yelp restaurant ratings.

##Technologies:

This project was built using [Ruby on Rails](http://rubyonrails.org/), [AngularJS](https://angularjs.org/) and PostgreSQL.

###AngularJS:

AngularJS is a JavaScript model-view-controller framework that allows dynamic updating of webpage elements. It was utilized in Crackerjack in order to update data without page refreshes, dynamically change page styling, and build several custom page elements.

###APIs:

APIs were built for the application in order to consume the data for the front-end. These APIs return JSON-formatted data on:

* Geolocated Instagram Photos at the Restaurant's latitude and longitude
* Yelp Restaurant Information
* Parsed Restaurant Reviews
* Sentiment Analysis of the reviews, Total Positive and Negative Reviews and Average Score

**If you have any questions regarding the project please contact:**

Greg Rock - grock006@gmail.com

