//
//  Tweet.h
//  WhisperiOSChallenge
//
//  Created by Jonathan Kim on 1/25/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * createdAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (void)getSearchResults:(NSManagedObjectContext *)moc withSearchString:(NSString *)searchString withCompletion:(void(^)(NSArray *))complete;
@end
