//
//  Employee_TableViewCell.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/8/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Employee_TableViewCell.h"

@implementation Employee_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _issue_view.layer.cornerRadius = 5.0f;
    _issue_view.layer.borderColor = [[UIColor redColor] CGColor]
    ;
    _issue_view.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
