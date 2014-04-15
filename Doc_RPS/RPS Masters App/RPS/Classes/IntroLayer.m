//
//  IntroLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntroLayer.h"
#import "AppDelegate.h"
#import "CCTouchDispatcher.h"
#import "MainMenuLayer.h"


@implementation IntroLayer

#pragma mark - MainMenuLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

#pragma mark DRAW FUNCTIONS
- (void) nextFrame:(ccTime)dt {
    if(!transitioning){
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
        transitioning=true;
    }
}


-(id) init
{
    if( (self=[super init])) {
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        transitioning=false;
        self.isTouchEnabled = YES;
    }
    
    return self;
}

@end
