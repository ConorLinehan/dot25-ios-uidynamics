//
//  Cell.m
//  DotsDribble
//
//  Created by Conor Linehan on 20/04/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

#import "Cell.h"

@implementation Cell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 25.0;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

@end
