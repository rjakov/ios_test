/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import "RootTableController.h"
#import "DetailsViewController.h"
#import "MyFilesCD.h"
#import "FileCD.h"
#import "CDManager.h"
#import "CustomCell.h"

#define kLoadingCellTag 12310
#define kPageLimit 20

@implementation RootTableController

@synthesize filesArray = _filesArray;


- (void)dealloc
{
    _filesArray = nil;
}


- (void) gotDataOK:(NSDictionary*) data {
    
    NSLog(@"gotDataOK:");
    _currentPage = 0;
    _pageCount = [[[data objectForKey:@"my_files"] objectForKey:@"content"] count];    
    NSArray* tmpArray = [[CDManager sharedInstance] requestSortingBy:@"item_id" andEntityName:@"FileCD" forLimit:kPageLimit andOffset:_currentPage*kPageLimit + 1];
    [self.filesArray addObjectsFromArray:tmpArray];
    [self.tableView reloadData];
   
}

- (void) gotDataFailed:(NSError*) error {
    
}

- (void) loadNextPage {
    
    NSLog(@"loadNextPage:");    
    NSArray* tmpArray = [[CDManager sharedInstance] requestSortingBy:@"item_id" andEntityName:@"FileCD" forLimit:kPageLimit andOffset:_currentPage*kPageLimit + 1];
    
    [self.filesArray addObjectsFromArray:tmpArray];
        
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.filesArray = [NSMutableArray array];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setTitle:@"YakimbiTest"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (_currentPage < _pageCount) {
        return self.filesArray.count + 1;
    }
    return self.filesArray.count;
}

- (UITableViewCell*) dataCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }    
    
    NSString* name = [[self.filesArray objectAtIndex:indexPath.row] name];
    NSString* status = [[self.filesArray objectAtIndex:indexPath.row] status];
    [cell.mainTextLabel setText:name];
    [cell.subTextLabel setText:status];
    
    
    return cell;
    
}

- (UITableViewCell*) loadingCell {
    
    UITableViewCell *cell = [[UITableViewCell alloc] 
                              initWithStyle:UITableViewCellStyleDefault
                              reuseIdentifier:nil];
    
    UIActivityIndicatorView *activityIndicator = 
    [[UIActivityIndicatorView alloc] 
     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = cell.center;
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    cell.tag = kLoadingCellTag;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.filesArray.count) {
        
        return [self dataCell:tableView cellForRowAtIndexPath:indexPath];        
    }
    else {
        
        return [self loadingCell];        
    }
        
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (cell.tag == kLoadingCellTag) {
        _currentPage++;
        [self loadNextPage];
    }
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
      
    
    DetailsViewController *detailsViewController = [[DetailsViewController alloc] init];
    detailsViewController.file = [self.filesArray objectAtIndex:indexPath.row];     
    [self.navigationController pushViewController:detailsViewController animated:YES];    
    
    
}

@end
