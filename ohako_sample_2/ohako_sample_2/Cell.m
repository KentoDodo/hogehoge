//
//  Cell.m
//  ohako_sample_2
//
//  Created by Dodo Kento on 2014/02/07.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "Cell.h"
#import "RakudaiView.h"

@implementation Cell {
    IBOutlet UIView *rakudaiView;
    RakudaiView *raku;
    int _value;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)didMoveToSuperview {
    raku=[[[NSBundle mainBundle] loadNibNamed:@"parts" owner:self options:nil] objectAtIndex:0];
    [rakudaiView addSubview:raku];
    [raku setValue:_value];
}

-(void)setValue:(int)value {
    _value=value;
}

@end
