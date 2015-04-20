//
//  CircleLayout.h
//  DotsDribble
//
//  Created by Conor Linehan on 20/04/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

@end
