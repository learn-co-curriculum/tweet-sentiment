//
//  FISTwitterAPIClient.h
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISTwitterAPIClient : NSObject

+ (void)getAveragePolarityOfTweetsFromQuery:(NSString *)query
                             withCompletion:(void (^)(NSNumber *polarity))completionBlock;

@end