//
//  SCRSlider.h
//  Scribbles
//
//  Created by Shane Sniteman on 8/4/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCRSliderDelegate;

@interface SCRSlider : UIView

@property (nonatomic) float maxWidth;
@property (nonatomic) float minWidth;

@property (nonatomic) float currentWidth;


@property (nonatomic) UIColor * lineColor;

@property (nonatomic,assign) id <SCRSliderDelegate> delegate;

@end

@protocol SCRSliderDelegate <NSObject>

- (void)updateLineWidth:(float)lineWidth;

@end


