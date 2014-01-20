//
//  ToDoItemCell.h
//  ToDo
//
//  Created by Autumn Victor on 1/17/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellDelegate
@optional
- (void)deleteButtonTappedOnCell:(id)sender;
@end

@interface ToDoItemCell : UITableViewCell
@property (nonatomic, strong) id  delegate;
@property (weak, nonatomic) IBOutlet UITextField *toDoItemText;
//@property (weak, nonatomic) IBOutlet UIButton *toDoItemCellDoneButton;

//- (IBAction)toDoItemCellDoneButtonClicked:(id)sender;
- (IBAction)onTextFieldDoneEditing:(id)sender;
-(IBAction)onDelete:(id)sender;

@end
