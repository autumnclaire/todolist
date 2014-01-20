//
//  ToDoListViewController.m
//  ToDo
//
//  Created by Autumn Victor on 1/17/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoItemCell.h"
#import <objc/runtime.h>


@interface ToDoListViewController ()


@property (strong, nonatomic) NSMutableArray *toDoItemList;

- (void)onAddButtonClicked;

- (NSMutableArray*) fetchToDoItemListFromDataStore;
- (void) updateToDoItemListInDataStore;

@end

@implementation ToDoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"To Do List";
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.toDoItemList = [[NSMutableArray alloc] init];
        [self updateToDoItemListInDataStore];
        
        //to keep the items in the list after you close the app, comment out the above two lines and uncommend the line below
//        self.toDoItemList = [self fetchToDoItemListFromDataStore];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *toDoCellNib = [UINib nibWithNibName:@"ToDoItemCell" bundle:nil];
    [self.tableView registerNib:toDoCellNib forCellReuseIdentifier:@"ToDoItemCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButtonClicked)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.toDoItemList = [self fetchToDoItemListFromDataStore];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


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
    [cell.toDoItemText setBorderStyle:UITextBorderStyleNone];
    cell.shouldIndentWhileEditing = YES;
    cell.toDoItemText.delegate = self;
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.toDoItemList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self updateToDoItemListInDataStore];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    NSObject *fromItem = [self.toDoItemList objectAtIndex:fromIndexPath.row];
    NSObject *toItem = [self.toDoItemList objectAtIndex:toIndexPath.row];
    
    [self.toDoItemList setObject:fromItem atIndexedSubscript:toIndexPath.row];
    [self.toDoItemList setObject:toItem atIndexedSubscript:fromIndexPath.row];
    [self updateToDoItemListInDataStore];
}

- (void)onAddButtonClicked {
    self.toDoItemList = [self fetchToDoItemListFromDataStore];
    [self.toDoItemList insertObject:@"" atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ToDoItemCell *newCell = [self.tableView cellForRowAtIndexPath:indexPath];
    [newCell.toDoItemText becomeFirstResponder];
    
    [self updateToDoItemListInDataStore];
    
    [self.tableView reloadData];
}

- (void) onDoneWithAddingButtonClicked {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButtonClicked)];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ToDoItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.toDoItemText resignFirstResponder];
    [self.toDoItemList setObject:cell.toDoItemText.text atIndexedSubscript:0];
    [self.tableView reloadData];
    [self updateToDoItemListInDataStore];
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

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneWithAddingButtonClicked)];
    self.navigationItem.rightBarButtonItem.title = @"Done";
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButtonClicked)];
//    self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    return YES;
}



@end
