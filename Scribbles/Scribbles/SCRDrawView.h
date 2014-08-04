//
//  SCRDrawView.h
//  Scribbles
//
//  Created by Shane Sniteman on 8/4/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCRDrawView : UIView

//@property (nonatomic) NSMutableArray * scribblePoints;

@property (nonatomic) NSMutableArray * scribbles;
@property (nonatomic) NSMutableArray * currentScribble;

@property (nonatomic) UIColor * lineColor;

@end
