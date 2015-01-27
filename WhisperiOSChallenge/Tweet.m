//
//  Tweet.m
//  WhisperiOSChallenge
//
//  Created by Jonathan Kim on 1/25/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

#import "Tweet.h"
#import "TwitterClient.h"


@implementation Tweet

@dynamic text;
//@dynamic createdAt;

+ (void)getSearchResults:(NSManagedObjectContext *)moc withSearchString:(NSString *)searchString withCompletion:(void(^)(NSArray *))complete
{
    [[TwitterClient sharedInstance] GET:[NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=%@", searchString]
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    NSLog(@"search successful");

                                    NSArray *statusesArray = responseObject[@"statuses"];
                                    NSMutableArray *searchTweetsArray = [@[] mutableCopy];

                                    for (NSDictionary *dict in statusesArray)
                                    {
                                        NSString *text = dict[@"text"];
                                        [searchTweetsArray addObject:text];
                                    }
                                    complete(searchTweetsArray);


                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    NSLog(@"search error");
                                    complete(nil);
                                }];
}

@end
