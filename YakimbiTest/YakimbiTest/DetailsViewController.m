/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import "DetailsViewController.h"
#import "CDManager.h"

@implementation DetailsViewController

@synthesize file = _file;

-(void) dealloc {
    
    [_file release], _file = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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

    NSManagedObject* fileCDEntDescr = [NSEntityDescription insertNewObjectForEntityForName:@"FileCD" inManagedObjectContext:[[CDManager sharedInstance] getManagedObjectContext]];
    NSDictionary *attributes = [[fileCDEntDescr entity] attributesByName];
    detailsRowCount = [attributes count];
    
    
    [self setTitle:self.file.name];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   

}

- (void) done 
{
    //NSLog(@"Subscription:done");
    //self.modalTransitionStyle = 3;
    [self dismissViewControllerAnimated:YES completion:nil];
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return detailsRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    /*@property (nonatomic, retain) NSString * created_date;
    @property (nonatomic, retain) NSString * is_shared;
    @property (nonatomic, retain) NSNumber * item_id;
    @property (nonatomic, retain) NSString * last_updated_by;
    @property (nonatomic, retain) NSString * last_updated_date;
    @property (nonatomic, retain) NSString * link;
    @property (nonatomic, retain) NSString * mime_type;
    @property (nonatomic, retain) NSString * name;
    @property (nonatomic, retain) NSNumber * parent_id;
    @property (nonatomic, retain) NSString * path;
    @property (nonatomic, retain) NSString * path_by_id;
    @property (nonatomic, retain) NSString * share_id;
    @property (nonatomic, retain) NSString * share_level;
    @property (nonatomic, retain) NSNumber * shared_by;
    @property (nonatomic, retain) NSString * shared_date;
    @property (nonatomic, retain) NSNumber * size;
    @property (nonatomic, retain) NSString * status;
    @property (nonatomic, retain) NSString * type;
    @property (nonatomic, retain) NSNumber * user_id;
    @property (nonatomic, retain) MyFilesCD *myfiles;*/

    
    NSString* propertyText = nil;
    NSString* detailedPrpText = nil;
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            
            propertyText = @"created data:";
            detailedPrpText = [NSString stringWithFormat:@"%@",self.file.created_date];
            break;
        case 1:
        
           propertyText = [NSString stringWithFormat:@"shared: %@", self.file.is_shared];
            break;
            
        case 2:
            
            propertyText = [NSString stringWithFormat:@"item id: %d", self.file.item_id ];
            break;
            
        case 3:
            
            propertyText = [NSString stringWithFormat:@"last updated by: %@", self.file.last_updated_by];
            break;
            
        case 4:
            
            propertyText = [NSString stringWithFormat:@"last updated date: %@", self.file.last_updated_date];
            break;
            
        case 5:
            
            propertyText = [NSString stringWithFormat:@"link: %@", self.file.link];
            break;
            
        case 6:
            
            propertyText = [NSString stringWithFormat:@"name: %@", self.file.name];
            break;
            
        case 7:
            
            propertyText = [NSString stringWithFormat:@"size: %d", self.file.size];
            break;
            
        default:
            break;
    }
    
    [cell.textLabel setText:propertyText];
    [cell.detailTextLabel setText:detailedPrpText];

        
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
    
    /* DetailsViewController *detailsViewController = [[DetailsViewController alloc] init];
     
    
    [self presentModalViewController:detailsViewController animated:NO];
    [detailsViewController release];*/
     
}

@end
