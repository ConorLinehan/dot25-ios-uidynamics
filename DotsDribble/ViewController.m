//
//  ViewController.m
//  DotsDribble
//
//  Created by Conor Linehan on 20/04/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

#import "ViewController.h"
#import "CircleLayout.h"
#import "Cell.h"


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIView *circle;
@property (nonatomic,strong)CircleLayout *layout;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellCount = 20;
    self.layout = [[CircleLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                             collectionViewLayout:self.layout];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
    
    [self.view addSubview:self.collectionView];
    
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.layout invalidateLayout];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
