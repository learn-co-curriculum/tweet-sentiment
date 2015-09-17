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
                NSString *requestString = @"https://api.twitter.com/1.1/search/tweets.json?include_entities=1&q=FlatironSchool";
                NSString *urlHost = [request.URL absoluteString];
                
                BOOL isThingEqual = [requestString isEqualToString:urlHost];
                NSLog(@"\n\n Request: %@ and are you equal? : %@\n\n", request, @(isThingEqual));
                
                return [requestString isEqualToString:urlHost];
            }
                                           withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                               
                                               
                                               NSDictionary *response = @{@"search_metadata": @{@"Data": @"<3"},
                                                                          @"statuses": tweets};
                                               
                                               
                                               
                                               
//                                               NSDictionary *searchMetadata = [response valueForKey:@"search_metadata"];
//                                               NSArray *statuses = [response valueForKey:@"statuses"];
                                               
                                               return [OHHTTPStubsResponse responseWithJSONObject:response
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
