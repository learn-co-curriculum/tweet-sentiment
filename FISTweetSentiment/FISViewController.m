//
//  FISViewController.m
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import "FISViewController.h"
#import "FISTwitterAPIClient.h"

@interface FISViewController ()

@property (weak, nonatomic) IBOutlet UILabel *polarityLabel;

@end


@implementation FISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:@"FlatironSchool"
                                              withCompletion:^(NSNumber *polarity) {
                                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                      self.polarityLabel.text = [polarity stringValue];
                                                  }];
                                              }];
}

@end