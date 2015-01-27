//
//  TwitterClient.m
//  WhisperiOSChallenge
//
//  Created by Jonathan Kim on 1/25/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"sXKduu9rmKy2SC6VMGDpFPuK6";
NSString * const kTwitterConsumerSecret = @"3pKSf8Mpd5u3dvKWHBf85CWeeujbAsutCCvIq2lQ5oDIQcvt5O";
NSString * const kTwitterBaseURL = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *)sharedInstance
{
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil)
        {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseURL]
                                                  consumerKey:kTwitterConsumerKey
                                               consumerSecret:kTwitterConsumerSecret];
        }
    });

    return instance;
}

@end
