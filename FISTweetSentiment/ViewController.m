//
//  ViewController.m
//  FISTweetSentiment
//
//  Created by James Campagno on 9/10/15.
//  Copyright (c) 2015 James Campagno. All rights reserved.
//

#import "ViewController.h"
#import "FISTwitterAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [FISTwitterAPIClient getTweetsFromQuery:@"DonaldTrump"
                             withCompletion:^(NSNumber *polairty) {
                                 NSLog(@"The average is %@", polairty);
                             }];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
