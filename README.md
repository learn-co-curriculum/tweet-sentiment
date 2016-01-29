

# Tweet Sentiment

Let's find out how The Flatiron School is doing on Social Media. We'll need two APIS to do this. One to get the tweets, and another to do what's called [sentiment analysis](http://en.wikipedia.org/wiki/Sentiment_analysis).

## Instructions

  1. Install the [STTwitter](https://github.com/nst/STTwitter) CocoaPod. 
  2. Do the appropriate method call to get all tweets with the query `FlatironSchool`. Use Twitter App Only Authentication. You'll have to get an App Key/Secret [here](https://apps.twitter.com/). If you don't have a twitter account already, you'll have to make one. 

  3. Once you have the tweets. Send each tweet for sentiment analysis via [The Sentiment 140 API](http://help.sentiment140.com/api). This returns a polarity value of 0 for negative, 2 for neutral and 4 for positive. Technically, we are supposed to use the Bulk Classification Service, but it's a bit confusing. I'd just use the Simple Classification Service. For both the `query` and the `text` key you will need to [URL encode](http://en.wikipedia.org/wiki/Percent-encoding) the `NSString` values. You can do this relatively simply with this code:

  ```
  NSString *unescaped = @"RT @RRombom: My answer to How successful are code bootcamps, like Dev Bootcamp and @FlatironSchool at job placement? [ask instructor for the link]";
  NSString *escapedString = [unescaped stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
  NSLog(@"escapedString: %@", escapedString);
  ```

  4. Your App should have just a label. When the app loads, it should request all of the tweets mentioning `FlatrionSchool` and then give an average sentiment for the term `FlatironSchool` displayed in the label.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/tweet-sentiment' title='Tweet Sentiment'>Tweet Sentiment</a> on Learn.co and start learning to code for free.</p>
