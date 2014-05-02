//
//  MyTableViewController.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/28/14.
//
//

#import "MyTableViewController.h"
#import "AppData.h"
//#import "AccountCell.h"
#import "Account.h"
#import "Strategy.h"
#import "TradeTrackerNotifications.h"


@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountsAndStrategiesUpdated) name:kUpdatedAccountList object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

  UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage tallImageNamed:@"bg"]];
  self.tableView.backgroundView = backgroundImageView;
//  self.edgesForExtendedLayout = UIRectEdgeAll;
//  self.automaticallyAdjustsScrollViewInsets = YES;
//  [self.tableView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
//  self.tableView.contentOffset

}

-(void)accountsAndStrategiesUpdated {
  [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
  [self putUpTheAddButtonIfNecessary];
}

-(void) putUpTheAddButtonIfNecessary {
  if ([[AppData appState].mainSort isEqualToString:kMainSortIsStrategies]) {
    if ([[[PFUser currentUser] objectForKey:@"level"] isEqualToString:@"SuperUser"]) {
      UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStrategy)];
      self.navigationItem.rightBarButtonItem = addButton;
    } else {
      self.navigationItem.rightBarButtonItem = nil;
    }
  } else {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
    self.navigationItem.rightBarButtonItem = addButton;
  }
}

-(void) addAccount {

}

-(void) addStrategy {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return ([[AppData appState].mainSort isEqualToString:kMainSortIsAccounts]) ? [AppData appState].accounts.count : [AppData appState].strategies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
  cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
