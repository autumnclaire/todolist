//
//  ToDoListViewController.m
//  ToDo
//
//  Created by Autumn Victor on 1/17/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoItemCell.h"

@interface ToDoListViewController ()


@property (weak, nonatomic) IBOutlet UIBarButtonItem *addToDoItemButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editToDoItemButton;

@property (strong, nonatomic) NSMutableArray *toDoItemList;

- (IBAction)onAddButtonClicked:(id)sender;
- (IBAction)onEditButtonClicked:(id)sender;

- (NSMutableArray*) fetchToDoItemListFromDataStore;
- (void) updateToDoItemListInDataStore;

@end

@implementation ToDoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.toDoItemList = [[NSMutableArray alloc] init];
//        self.toDoItemList = [self fetchToDoItemListFromDataStore];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.toDoItemList forKey:@"toDoItemList"];
        [defaults synchronize];
    }
    return self;
}

- (NSMutableArray*) fetchToDoItemListFromDataStore {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedList = [defaults objectForKey:@"toDoItemList"];
    return [[NSMutableArray alloc] initWithArray:savedList];
}

- (void) updateToDoItemListInDataStore {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.toDoItemList forKey:@"toDoItemList"];
    [defaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *toDoCellNib = [UINib nibWithNibName:@"ToDoItemCell" bundle:nil];
    [self.tableView registerNib:toDoCellNib forCellReuseIdentifier:@"ToDoItemCell"];
    
    self.toDoItemList = [self fetchToDoItemListFromDataStore];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.toDoItemList = [self fetchToDoItemListFromDataStore];
    
    return [self.toDoItemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ToDoItemCell";
    ToDoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *toDoItem = [self.toDoItemList objectAtIndex:indexPath.row];
    
    cell.toDoItemText.text = toDoItem;
    
    return cell;
}

- (IBAction)onAddButtonClicked:(id)sender {
    self.toDoItemList = [self fetchToDoItemListFromDataStore];
    [self.toDoItemList addObject:[[NSString alloc] init]];

    [self updateToDoItemListInDataStore];
    
    [self.tableView reloadData];
}

- (IBAction)onEditButtonClicked:(id)sender {
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


@end
