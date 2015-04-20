//
//  CircleLayout.m
//  DotsDribble
//
//  Created by Conor Linehan on 20/04/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

#import "CircleLayout.h"

#define ITEM_SIZE 50

@interface CircleLayout()

@property(nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property(nonatomic, strong) NSMutableArray *insertIndexPaths;

@property(nonatomic,strong) UIDynamicAnimator *dynamicAnimator;

@end

@implementation CircleLayout

-(id)init{
    self = [super init];
    
    if (self) {
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize size = self.collectionView.frame.size;
        self.cellCount = [[self collectionView] numberOfItemsInSection:0];
        self.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
        self.radius = MIN(size.width, size.height) / 2.5;
    }
    
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    CGSize size = self.collectionView.frame.size;
    self.cellCount = [[self collectionView] numberOfItemsInSection:0];
    self.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
    self.radius = MIN(size.width, size.height) / 2.5;
    
    CGRect visibleRect =
    CGRectInset((CGRect){.origin = self.collectionView.bounds.origin, .size = self.collectionView.frame.size},
                self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
//    [itemsVisibleInArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger idx, BOOL *stop){
//        
//        
//        CGPoint center = CGPointMake(_center.x + _radius * cosf(2 * idx * M_PI / _cellCount),
//                                  _center.y + _radius * sinf(2 * idx * M_PI / _cellCount));
//        
//        UIAttachmentBehavior *springBehaviour = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:center];
//        
//        springBehaviour.length = 0.0f;
//        springBehaviour.damping = 0.8f;
//        springBehaviour.frequency = 1.0f;
//        
//        item.center = center;
//        
//        UIDynamicItemBehavior *bump = [[UIDynamicItemBehavior alloc] initWithItems:@[item]];
//        
//        [self.dynamicAnimator addBehavior:springBehaviour];
//        [self.dynamicAnimator addBehavior:bump];
//        
//    }];
    
}

-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount),
                                    _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
    
    UIAttachmentBehavior *springBehaviour = [[UIAttachmentBehavior alloc] initWithItem:attributes attachedToAnchor:attributes.center];
    
    springBehaviour.length = 0.0f;
    springBehaviour.damping = 0.8f;
    springBehaviour.frequency = 1.0f;

    

    UIDynamicItemBehavior *bump = [[UIDynamicItemBehavior alloc] initWithItems:@[attributes]];
    [bump addLinearVelocity:CGPointMake(20, 20) forItem:attributes];
    

    [self.dynamicAnimator addBehavior:springBehaviour];
    [self.dynamicAnimator addBehavior:bump];
//    [self.dynamicAnimator addBehavior:g];
    
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
    
//    return [self.dynamicAnimator itemsInRect:rect];
}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
//}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    NSLog(@"Called Invalidated");
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *behaviour, NSUInteger idx, BOOL *stop){
        
        UICollectionViewLayoutAttributes *item = [behaviour.items firstObject];
        
        item.center = CGPointMake(_center.x + _radius * cosf(2 * idx * M_PI / _cellCount),
                                                                      _center.y + _radius * sinf(2 * idx * M_PI / _cellCount));
        
    }];
    
    return NO;
}


//- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
//{
//    // Keep track of insert and delete index paths
//    [super prepareForCollectionViewUpdates:updateItems];
//    
//    self.deleteIndexPaths = [NSMutableArray array];
//    self.insertIndexPaths = [NSMutableArray array];
//    
//    for (UICollectionViewUpdateItem *update in updateItems)
//    {
//        if (update.updateAction == UICollectionUpdateActionDelete)
//        {
//            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
//        }
//        else if (update.updateAction == UICollectionUpdateActionInsert)
//        {
//            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
//        }
//    }
//}

//- (void)finalizeCollectionViewUpdates
//{
//    [super finalizeCollectionViewUpdates];
//    // release the insert and delete index paths
//    self.deleteIndexPaths = nil;
//    self.insertIndexPaths = nil;
//}

// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    // Must call super
//    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
//    
//    if ([self.insertIndexPaths containsObject:itemIndexPath])
//    {
//        // only change attributes on inserted cells
//        if (!attributes)
//            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//        
//        // Configure attributes ...
//        attributes.alpha = 0.0;
//        attributes.center = CGPointMake(_center.x, _center.y);
//    }
//    
//    return attributes;
//}

// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    // So far, calling super hasn't been strictly necessary here, but leaving it in
//    // for good measure
//    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
//    
//    if ([self.deleteIndexPaths containsObject:itemIndexPath])
//    {
//        // only change attributes on deleted cells
//        if (!attributes)
//            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//        
//        // Configure attributes ...
//        attributes.alpha = 0.0;
//        attributes.center = CGPointMake(_center.x, _center.y);
//        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
//    }
//    
//    return attributes;
//
//
//}
@end
