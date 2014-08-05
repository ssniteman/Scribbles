//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by Shane Sniteman on 8/4/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"
#import "SCRSlider.h"

@interface SCRDrawViewController () <SCRSliderDelegate>

@end

@implementation SCRDrawViewController
{
    SCRSlider * lineSlider;
    UIView * lineWidthSize;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view = [[SCRDrawView alloc] initWithFrame:self.view.frame];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray * colors = @[
                         [UIColor cyanColor],
                         [UIColor magentaColor],
                         [UIColor yellowColor],
                         [UIColor blueColor]
                         ];
    
    for (UIColor * color in colors)
    {
        NSInteger index = [colors indexOfObject:color];
        
        NSLog(@"%d",(int)index);
        
        UIButton * colorButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10 + (50 * index), 40, 40)];
        
        
    colorButton.backgroundColor = color;
    colorButton.layer.cornerRadius = 20;
    
    [colorButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:colorButton];
        
    }
    
    lineWidthSize = [[UIView alloc] initWithFrame:CGRectMake(0,0, 2,2)];
    lineWidthSize.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineWidthSize];
    
    UIButton * openLineWidthSlider = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 60, 40, 40)];
    openLineWidthSlider.layer.cornerRadius = 20;
    openLineWidthSlider.layer.borderWidth = 1.0;
    openLineWidthSlider.layer.borderColor = [UIColor blackColor].CGColor;
    
    [openLineWidthSlider addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:openLineWidthSlider];
    
    lineWidthSize.center = openLineWidthSlider.center;
    

   
    
    
    
   
}

- (void)openSlider
{
    if (lineSlider)
    {
        [lineSlider removeFromSuperview];
        lineSlider = nil;
        return;
    }
    
    
    // pointing to SCRSlider file subview
    
    lineSlider = [[SCRSlider alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 280, 40, 200)];
    
    lineSlider.currentWidth = self.view.lineWidth;
    
    lineSlider.delegate = self;
    
    [self.view addSubview:lineSlider];
    
}



- (void)updateLineWidth:(float)lineWidth
{
    self.view.lineWidth = lineWidth;
    
    CGPoint center = lineWidthSize.center;
    lineWidthSize.frame = CGRectMake(0, 0, lineWidth * 2, lineWidth * 2);
    lineWidthSize.center = center;
    lineWidthSize.layer.cornerRadius = lineWidth;
}



- (void)changeLineColor:(UIButton *)button
{
    SCRDrawView * view = (SCRDrawView *)self.view;
    
    view.lineColor = button.backgroundColor;
    [view setNeedsDisplay];
}

-(BOOL)prefersStatusBarHidden { return YES; }

@end
