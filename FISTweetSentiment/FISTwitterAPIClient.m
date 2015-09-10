//
//  FISTwitterAPIClient.m
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import "FISTwitterAPIClient.h"
#import "FISConstants.h"
#import "FISSentiment140API.h"
#import <STTwitter.h>

@implementation FISTwitterAPIClient

+ (void)getTweetsFromQuery:(NSString *)query
            withCompletion:(void (^)(NSNumber *polairty))completionBlock {
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:TWITTER_KEY
                                                            consumerSecret:TWITTER_SECRET];
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        [twitter getSearchTweetsWithQuery:query
                             successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
                                 
                                 NSLog(@"About to pass forward the completion block to another method myf riend");
                                 
                                 [FISSentiment140API getPolarityOfTweets:statuses
                                                               fromQuery:query
                                                          withCompletion:completionBlock];
                                 
                             } errorBlock:^(NSError *error) {
                                 NSLog(@"Error with searching for the tweets with %@ - %@", query, error.localizedDescription);
                             }];
    } errorBlock:^(NSError *error) {
        NSLog(@"Error verifying the credientials.  %@", error.localizedDescription);
    }];
}

@end
