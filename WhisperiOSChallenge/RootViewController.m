//
//  ViewController.m
//  WhisperiOSChallenge
//
//  Created by Jonathan Kim on 1/25/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property NSManagedObjectContext *moc;
@property (strong, nonatomic)  NSArray *searchArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

}

-(void)setSearchArray:(NSMutableArray *)searchArray
{
    _searchArray = searchArray;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSString *tweet = self.searchArray[indexPath.row];

    cell.tweetLabel.text = tweet;

    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *textResult = searchBar.text;
    textResult = [textResult stringByReplacingOccurrencesOfString:@" " withString:@""];

    [Tweet getSearchResults:self.moc
           withSearchString:textResult withCompletion:^(NSArray *searchArray) {
               self.searchArray = searchArray;
           }];
}



@end
