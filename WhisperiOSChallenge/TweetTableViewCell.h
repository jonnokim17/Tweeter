//
//  TweetTableViewCell.h
//  WhisperiOSChallenge
//
//  Created by Jonathan Kim on 1/25/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
