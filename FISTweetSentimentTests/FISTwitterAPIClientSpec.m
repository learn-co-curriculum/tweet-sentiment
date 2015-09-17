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
static NSString *const kTwitterOauthURL = @"https://api.twitter.com/oauth2/token";
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
                BOOL isTwitterOauth = [[request.URL absoluteString] isEqualToString:kTwitterOauthURL];
                (isTwitterOauth) ? NSLog(@"YES - It's Twitter Oauth\n\n\n") : NSLog(@"NO - It's Not.\n\n\n");
                
                return YES;
                
//                return isTwitterOauth;
                
                NSString *requestURLString = [request.URL absoluteString];
                BOOL containsTwitterString = [requestURLString containsString:kTwitterRequestURL];
//                return containsTwitterString;
            }
                                                  withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                                                      
                                                      NSLog(@"STUB TIME!!!!!!!!!!!!!!");
//                                                      "access_token" = "AAAAAAAAAAAAAAAAAAAAAKhwYwAAAAAAmlOWAsDKZoDGunCOxo4lAMGDzGw%3DxJl8QbmYUi7vtTilTRcME4XljrZFik9VSXa9smdo90ibGLzr5Y";
//                                                      "token_type" = bearer;
                                                      
                                                      
                                                      
                                                      NSDictionary *test = @{@"access_token": @"DONALD TRUMP",
                                                                             @"token_type": @"bearer"};
                                                      
//                                                      NSString *tokenType = [json valueForKey:@"token_type"];
                                                      return [OHHTTPStubsResponse responseWithJSONObject:test
                                                                                              statusCode:200
                                                                                                 headers:@{@"Content-type": @"application/json"}];
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
//                                                      return [OHHTTPStubsResponse responseWithJSONObject:responseObject
//                                                                                              statusCode:200
//                                                                                                 headers:@{@"Content-type": @"application/json"}];
                                                  }];

            
//            httpSentimentStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//                NSString *requestURLString = [request.URL absoluteString];
//                BOOL containsSentimentString = [requestURLString containsString:kSentimentRequestURL];
//                return containsSentimentString;
//            }
//                                                    withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
//                                                        NSString *jsonString = @"{\"results\": {\"polarity\": \"15\"}}";
//                                                        NSData *stubData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//                                                        return [OHHTTPStubsResponse responseWithData:stubData
//                                                                                          statusCode:200
//                                                                                             headers:nil];
//                                                    }];
            
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
        
        //        it(@"Should get the polarity of the tweets using the sentiment140 API", ^{
        //
        //            waitUntil(^(DoneCallback done) {
        //
        //                [FISSentiment140API getPolarityOfTweets:tweets
        //                                              fromQuery:query
        //                                         withCompletion:^(NSNumber *polarity) {
        //
        //                                             expect(polarity).to.beAKindOf([NSNumber class]);
        //                                             expect(polarity).notTo.equal(nil);
        //                                             expect(polarity).to.equal(10);
        //                                             expect(polarity).notTo.equal(0);
        //
        //                                             done();
        //                                         }];
        //            });
        //        });
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
