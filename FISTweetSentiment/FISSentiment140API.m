//
//  FISSentiment140API.m
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import "FISSentiment140API.h"
#import "FISConstants.h"

@implementation FISSentiment140API

+ (void)getPolarityOfTweets:(NSArray *)tweets
                  fromQuery:(NSString *)query
             withCompletion:(void (^)(NSNumber *polarity))completionBlock {
    
    __block NSInteger polarityValue = 0;
    __block NSInteger averagePolarityValue;
    NSURLSession *mySession = [NSURLSession sharedSession];
    
    
    for (NSInteger i = 0; i < [tweets count]; i++) {
        NSDictionary *tweet = tweets[i];
        NSString *unescapedTweetString = tweet[@"text"];
        NSString *escapedTweetString = [unescapedTweetString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        
        NSString *sentimentedString = [NSString stringWithFormat:@"%@&query=%@&text=%@",SENTIMENT140_BASE_URL, query, escapedTweetString];
        
        NSURL *sentiment140URL = [NSURL URLWithString:sentimentedString];
        
        NSURLSessionDataTask *task = [mySession dataTaskWithURL:sentiment140URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *polarity = resultsDictionary[@"results"][@"polarity"];
            
            polarityValue += [polarity integerValue];
            NSLog(@"New polarity value: %ld", polarityValue);

            if (i == [tweets count]-1) {
                NSLog(@"Done!");
                averagePolarityValue = polarityValue/[tweets count];
                
                completionBlock(@(averagePolarityValue));
            }
        }];
        
        [task resume];
    }
}

@end
