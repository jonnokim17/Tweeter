//
//  SavedTweetsViewController.m
//  WhisperiOSChallenge
//
//  Created by Jonathan Kim on 1/26/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

#import "SavedTweetsViewController.h"
#import "AppDelegate.h"
#import "Tweet.h"
#import "SavedTweetsTableViewCell.h"

@interface SavedTweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *savedTweets;

@end

@implementation SavedTweetsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadSavedTweets];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)setSavedTweets:(NSMutableArray *)savedTweets
{
    _savedTweets = savedTweets;
    [self.tableView reloadData];
}

- (void)loadSavedTweets
{
    self.savedTweets = [@[] mutableCopy];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Tweet class])];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"text"
                                                                                     ascending:YES]];
    self.savedTweets = [[self.moc executeFetchRequest:request error:nil] mutableCopy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.savedTweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SavedTweetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                                     forIndexPath:indexPath];

    Tweet *savedTweets = self.savedTweets[indexPath.row];
    cell.savedTweetsLabel.text = savedTweets.text;

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.savedTweets[indexPath.row];
    [self.savedTweets removeObject:tweet];

    [self.moc deleteObject:tweet];
    [self.moc save:nil];

    [self.tableView reloadData];
}


@end
