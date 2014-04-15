//
//  RootViewController.h
//  RPS
//
//  Created by chibitotoro on 12-05-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>


@interface RootViewController : UIViewController<ADBannerViewDelegate> {
    
    ADBannerView *bannerView;
    
}
@property (nonatomic,retain) ADBannerView *bannerView;

@end