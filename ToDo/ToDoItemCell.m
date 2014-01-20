//
//  ToDoItemCell.m
//  ToDo
//
//  Created by Autumn Victor on 1/17/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import "ToDoItemCell.h"

@implementation ToDoItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)toDoItemCellDoneButtonClicked:(id)sender {
//    [self endEditing: YES];    //dismisses the keyboard
//
//    [self updateToDoItemsList]; 
//}

-(IBAction)onTextFieldDoneEditing:(id)sender {
    [self endEditing: YES];    //dismisses the keyboard
    [self updateToDoItemsList];
    

}

- (void) updateToDoItemsList {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *toDoItemList = [defaults objectForKey:@"toDoItemList"];
    
    NSMutableArray *newList = [[NSMutableArray alloc] initWithArray:toDoItemList];
    newList[newList.count - 1] = self.toDoItemText.text;
    
    [defaults setObject:newList forKey:@"toDoItemList"];
    [defaults synchronize];
}



@end
