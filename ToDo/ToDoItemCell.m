//
//  ToDoItemCell.m
//  ToDo
//
//  Created by Autumn Victor on 1/17/14.
//  Copyright (c) 2014 Autumn Victor. All rights reserved.
//

#import "ToDoItemCell.h"
#import <objc/runtime.h>


@implementation ToDoItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
