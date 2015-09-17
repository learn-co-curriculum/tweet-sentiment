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

static NSString *const kTwitterRequestURL = @"api.twitter.com";
static NSString *const kSentimentRequestURL = @"sentiment140";

describe(@"FISTwitterAPIClient", ^{
    
    __block id<OHHTTPStubsDescriptor> httpTwitterStub;
    __block id<OHHTTPStubsDescriptor> httpSentimentStub;
    __block NSString *filePath;
    __block NSString *query;
    __block NSArray *tweets;
    __block NSDictionary *responseObject;
    
    beforeAll(^{
        filePath = [[NSBundle mainBundle] pathForResource:@"fakeJSON" ofType:@"json"];
        tweets = [NSArray arrayWithContentsOfFile:filePath];
        responseObject = @{@"search_metadata": @{@"Data": @"<3"},
                           @"statuses": tweets};
        query = @"FlatironSchool";
    });
    
    describe(@"requestLocationsWithSuccess:failure:", ^{
        
        beforeEach(^{
            
            [OHHTTPStubs removeAllStubs];
            httpTwitterStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                NSString *requestURLString = [request.URL absoluteString];
                BOOL containsTwitterString = [requestURLString containsString:kTwitterRequestURL];
                NSLog(@"\n\nREQuest from twitterstub: %@", request);
                (containsTwitterString) ?  : NSLog(@"\n\n********============NO============\n\n");
                
                
                
//                NSLog(@"\n\n\nRequest from the TWITTER STUB : %@\n\n\n", request);
                return [[request.URL absoluteString] isEqualToString:kTwitterRequestURL];
            }
                                                  withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                                      return [OHHTTPStubsResponse responseWithJSONObject:responseObject
                                                                                              statusCode:200
                                                                                                 headers:@{@"Content-type": @"application/json"}];
                                                  }];
            
            [OHHTTPStubs setEnabled:YES];
            
        
            
            httpSentimentStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//                NSLog(@"\n\n\nRequest from the SENTIMENET STUB : %@\n\n\n", request);
                NSString *requestURLString = [request.URL absoluteString];
                BOOL containsSentimentString = [requestURLString containsString:kSentimentRequestURL];
                NSLog(@"\n\nREQuest from sentiment: %@", request);

                (containsSentimentString) ?  : NSLog(@"\n\n********============NO============\n\n");
                return containsSentimentString;
//                BOOL isSentiment = [[request.URL absoluteString] isEqualToString:kSentimentRequestURL];
//                (isSentiment) ? NSLog(@"\n\n===YES===\n\n") : NSLog(@"\n\n===NO===\n\n");
//                return [[request.URL absoluteString] isEqualToString:kSentimentRequestURL];
            }
                                                    withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                                        NSString *jsonString = @"{\"results\": {\"polarity\": \"10\"}}";
                                                        NSData *stubData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                                                        return [OHHTTPStubsResponse responseWithData:stubData
                                                                                          statusCode:200
                                                                                             headers:nil];
                                                        
                            
                                                        //                                                        NSDictionary *test = @{@"results": @{@"polarity": @"5"}};
                                                        //                                                        NSData *responseData = [NSKeyedArchiver archivedDataWithRootObject:test];
                                                        
                                                        
                                                        
                                                        //                                                        return [OHHTTPStubsResponse responseWithData:responseData
                                                        //                                                                                          statusCode:200
                                                        //                                                                                             headers:nil];
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        //                                                        NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        //                                                        NSString *polarity = resultsDictionary[@"results"][@"polarity"];
                                                        
                                                        
                                                        
                                                        
                            
                                                        
                                                    }];
            
        });
        
        it(@"should get the average polarity of tweets from the provided query.", ^{
            
            waitUntil(^(DoneCallback done) {
                
                [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:@"FlatironSchool"
                                                          withCompletion:^(NSNumber *polarity) {
                                                              
                                                              expect(polarity).to.beAKindOf([NSNumber class]);
                                                              expect(polarity).notTo.equal(nil);
                                                              expect(polarity).to.equal(10);
                                                              expect(polarity).notTo.equal(0);
                                                              
                                                              done();
                                                          }];
            });
        });
        
        it(@"Should get the polarity of the tweets using the sentiment140 API", ^{
            
            waitUntil(^(DoneCallback done) {
                
                [FISSentiment140API getPolarityOfTweets:tweets
                                              fromQuery:query
                                         withCompletion:^(NSNumber *polarity) {
                                             
                                             expect(polarity).to.beAKindOf([NSNumber class]);
                                             expect(polarity).notTo.equal(nil);
                                             expect(polarity).to.equal(10);
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
