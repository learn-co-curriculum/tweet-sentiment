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

+ (void)getAveragePolarityOfTweetsFromQuery:(NSString *)query
                             withCompletion:(void (^)(NSNumber *polarity))completionBlock {
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:TWITTER_KEY
                                                            consumerSecret:TWITTER_SECRET];
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        
        
        [twitter getSearchTweetsWithQuery:query
                             successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
                                 
                                 NSLog(@"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ META DATA: %@", searchMetadata);
                                                                  
                                 [FISSentiment140API getPolarityOfTweets:statuses
                                                               fromQuery:query
                                                          withCompletion:completionBlock];
                             } errorBlock:^(NSError *error) {
                                 NSLog(@"%@", error.localizedDescription);
                             }];
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
