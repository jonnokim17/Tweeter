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
@dynamic createdAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self)
    {
        self.text = dictionary[@"text"];

        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formattter = [[NSDateFormatter alloc] init];
        formattter.dateFormat = @"EEE MMM d HH:mm:ss Z y";

        self.createdAt = [formattter dateFromString:createdAtString];
    }

    return self;
}

+ (void)getSearchResults:(NSManagedObjectContext *)moc withSearchString:(NSString *)searchString withCompletion:(void(^)(NSArray *))complete
{
    [[TwitterClient sharedInstance] GET:[NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=%@", searchString]
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    NSLog(@"search successful");

                                    NSArray *statusesArray = responseObject[@"statuses"];

                                    NSMutableArray *searchTweetsArray = [@[] mutableCopy];

                                    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:moc];

                                    Tweet *tweet = [[Tweet alloc] initWithEntity:entityDescription
                                                  insertIntoManagedObjectContext:moc];

                                    for (NSDictionary *dict in statusesArray)
                                    {
                                        tweet.text = dict[@"text"];

                                        [searchTweetsArray addObject:tweet.text];

                                    }
                                    complete(searchTweetsArray);


                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    NSLog(@"search error");
                                    complete(nil);
                                }];
}

@end
