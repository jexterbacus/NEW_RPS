//
//  RootViewController.m
//  RPS
//
//  Created by chibitotoro on 12-05-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize bannerView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Obtain the shared director in order to...
    CCDirector *director = [CCDirector sharedDirector];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(3.14159/2);
    self.view.transform = transform;
	
    // Repositions and resizes the view.
    CGRect contentRect = CGRectMake(0, 0, 480, 320);
    self.view.bounds = contentRect;
    
    // Turn on multiple touches
    /*
    CCGLView *eaglView = (CCGLView*)[director view];
    [eaglView setMultipleTouchEnabled:YES];
    [self.view addSubview:eaglView];
    */
    [self.view addSubview:[director view]];
    static NSString * const kADBannerViewClass = @"ADBannerView";
    if (NSClassFromString(kADBannerViewClass) != nil) {
        
        self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        [self.bannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects:
                                                            ADBannerContentSizeIdentifier320x50,
                                                            ADBannerContentSizeIdentifier480x32, nil]];
        
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier480x32;
        
        [self.bannerView setDelegate:self];
        
        [self.view addSubview:self.bannerView];
        [self moveBannerOffScreen];
        
    }
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"FAILED TO LOAD AD");
    [self moveBannerOffScreen];
    [bannerView setHidden:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void) moveBannerOffScreen
{
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    
    self.bannerView.frame = CGRectMake(0, windowSize.height, 480, 32);
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [bannerView setHidden:NO];
    NSLog(@"bannerViewDidLoadAd");
    
    [self moveBannerOnScreen];   
}

-(void) moveBannerOnScreen
{
    
    [UIView beginAnimations:@"BannerViewIntro" context:NULL];
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    self.bannerView.frame = CGRectMake(0, windowSize.height-32, 480, 32);
    [UIView commitAnimations];
}



@end
