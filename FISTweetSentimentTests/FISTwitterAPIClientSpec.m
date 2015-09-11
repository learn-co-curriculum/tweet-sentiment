//
//  FISTwitterAPIClientSpec.m
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright 2015 James Campagno. All rights reserved.
//

#import "Specta.h"
#import "AppDelegate.h"
#import "FISTwitterAPIClient.h"
#import "FISSentiment140API.h"
#import "FISConstants.h"
#import "OHHTTPStubs.h"
#define EXP_SHORTHAND
#import "Expecta.h"


SpecBegin(FISTwitterAPIClient)

describe(@"FISTwitterAPIClient", ^{
    
    __block id<OHHTTPStubsDescriptor> httpStub;
    __block NSString *filePath;
    __block NSArray *tweets;
    
    beforeAll(^{
        filePath = [[NSBundle mainBundle] pathForResource:@"fakeJSON" ofType:@"json"];
        tweets = [NSArray arrayWithContentsOfFile:filePath];
    });
    
    describe(@"requestLocationsWithSuccess:failure:", ^{
        
        beforeEach(^{
            
            [OHHTTPStubs removeAllStubs];
            httpStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                
                return [request.URL.host isEqualToString:@"api.twitter.com"];
                
//                return ([request.URL.host isEqualToString:@"api.twitter.com"] ||
//                        [request.URL.host isEqualToString:@"www.sentiment140.com"]);
            }
                                           withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                               
                                               return [OHHTTPStubsResponse responseWithJSONObject:tweets
                                                                                       statusCode:200
                                                                                          headers:@{@"Content-type": @"application/json"}];
                                               
                                        
                                               
                                               
                                           }];
        });
        
        it(@"should get the average polarity of tweets from the provided query.", ^{
            
            waitUntil(^(DoneCallback done) {
                
                [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:@"FlatironSchool"
                                                          withCompletion:^(NSNumber *polarity) {
                                                              
                                                              
                                                              NSLog(@"\n\n\nPolarity is %@\n\n\n", polarity);
                                                          }];
                
                
            });
        });
    });
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    beforeEach(^{
        
    });
    
    it(@"", ^{
        
    });
    
    afterEach(^{
        
    });
    
    afterAll(^{
        
    });
});

SpecEnd
