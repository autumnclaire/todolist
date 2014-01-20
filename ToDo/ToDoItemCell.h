//
//  ToDoItemCell.h
//  ToDo
//
//  Created by Autumn Victor on 1/17/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *toDoItemText;
//@property (weak, nonatomic) IBOutlet UIButton *toDoItemCellDoneButton;

//- (IBAction)toDoItemCellDoneButtonClicked:(id)sender;
- (IBAction)onTextFieldDoneEditing:(id)sender;

@end
