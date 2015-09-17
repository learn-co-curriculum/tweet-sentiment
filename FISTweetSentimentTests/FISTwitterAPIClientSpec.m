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
    __block NSDictionary *responseObject;
    
    beforeAll(^{
        filePath = [[NSBundle mainBundle] pathForResource:@"fakeJSON" ofType:@"json"];
        tweets = [NSArray arrayWithContentsOfFile:filePath];
        responseObject = @{@"search_metadata": @{@"Data": @"<3"},
                           @"statuses": tweets};
    });
    
    describe(@"requestLocationsWithSuccess:failure:", ^{
        
        beforeEach(^{
            
            [OHHTTPStubs removeAllStubs];
            httpStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                NSString *requestString = @"https://api.twitter.com";
                NSString *urlHost = [request.URL absoluteString];
                return [requestString isEqualToString:urlHost];
            }
                                           withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                               
                                               NSLog(@"\n\nWHATS UP DUDE!!!!!!!!!!!!!!");
                                               
                                               return [OHHTTPStubsResponse responseWithJSONObject:responseObject
                                                                                       statusCode:200
                                                                                          headers:@{@"Content-type": @"application/json"}];
                                           }];
            
            
            
        });
        
        it(@"should get the average polarity of tweets from the provided query.", ^{
            
            waitUntil(^(DoneCallback done) {
                
                [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:@"FlatironSchool"
                                                          withCompletion:^(NSNumber *polarity)
                 
                                                              expect(polarity).to.beAKindOf([NSNumber class]);
                                                              expect(polarity).notTo.equal(nil);
                                                              expect(polarity).to.equal(2);
                                                              expect(polarity).notTo.equal(0);
                 
                                                              done();
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
