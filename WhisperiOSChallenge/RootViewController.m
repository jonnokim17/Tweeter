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
#import "SavedTweetsViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *searchArray;
@property NSMutableArray *savedTweets;

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

#pragma mark - Tableview datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                               forIndexPath:indexPath];

    NSString *tweet = self.searchArray[indexPath.row];
    cell.tweetLabel.text = tweet;

    return cell;
}

#pragma mark - searchbar delegate method
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *textResult = searchBar.text;

    // In order to be able to search with space
    textResult = [textResult stringByReplacingOccurrencesOfString:@" " withString:@""];

    // Search tweet block callback
    [Tweet getSearchResults:self.moc
           withSearchString:textResult withCompletion:^(NSArray *searchArray) {
               self.searchArray = searchArray;
           }];
    
    [searchBar resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create alert to either save tweet or not when cell is clicked
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"Would you like to save this tweet?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          Tweet *tweet = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet"
                                                                                                       inManagedObjectContext:self.moc];
                                                          tweet.text = self.searchArray[indexPath.row];

                                                          // Save tweet
                                                          [self.moc save:nil];
                                                      }];

    UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

    [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SavedTweetsViewController *savedTweetsVC = segue.destinationViewController;
    savedTweetsVC.moc = self.moc;
}


@end
