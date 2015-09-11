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
    
    describe(@"requestLocationsWithSuccess:failure:", ^{
        
        beforeEach(^{
            
            [OHHTTPStubs removeAllStubs];
            httpStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {

                NSLog(@"\n\n============================ Stub Request =============");
                
                return [request.URL.host isEqualToString:@"api.twitter.com/oauth2/token"];
                
                
            }
                        
                                           withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                               
                                               
                                               NSLog(@"\n\n============= Going to return a request here? =======");
                                               
                                               return nil;
                                           }];
        });
        
        it(@"should get the average polarity of tweets from the provided query.", ^{
            
            waitUntil(^(DoneCallback done) {
                
                NSLog(@"\n\n=========About to call API Client =============");
                
                [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:@"FlatironSchool"
                                                          withCompletion:^(NSNumber *polarity) {
                                                              
                                                              
                                                              NSLog(@"Polarity is %@", polarity);
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
