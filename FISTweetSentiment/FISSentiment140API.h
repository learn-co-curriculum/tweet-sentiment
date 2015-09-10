//
//  FISSentiment140API.h
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISSentiment140API : NSObject

+ (void)getPolarityOfTweets:(NSArray *)tweets
                  fromQuery:(NSString *)query
             withCompletion:(void (^)(NSNumber *polarity))completionBlock;

@end
