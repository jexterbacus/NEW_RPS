//
//  AboutLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutLayer.h"
#import "MainMenuLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
@implementation AboutLayer

#pragma mark - AboutLayer

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	AboutLayer *layer = [AboutLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init{
    if((self=[super init])){
        
        /*
         // schedule a repeating callback on every frame
         [self schedule:@selector(nextFrame:)];
         
         self.isTouchEnabled = YES;
         */
        
        
        // ask director the the window size
        //CGSize size = [[CCDirector sharedDirector] winSize];
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
        
        sprBackground=[CCSprite spriteWithFile:@"about-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        // Return Button
        // Return Home
        itmReturn = [CCMenuItemImage itemWithNormalImage:@"return-home.png" 
                                           selectedImage:@"return-home.png" 
                                                   block:^(id sender) {
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                       [[CCDirector sharedDirector] replaceScene:
                                                        [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
                                                   }];    
        
        itmReturn.position=ccp(93,58);
        
        menu = [CCMenu menuWithItems:itmReturn, nil];
        
        [menu setPosition:ccp(0,0)];
        
        
        lblContent = [CCLabelTTF labelWithString:@"Welcome to the first release of RPS Masters, constructed by Createconvert Media Ltd.  Put your Rock Paper Scissors skills to the test against all 5 characters on 3 different stages.  Play against the computer or with your friends via Game Center.\n\nTo learn more details and updates please visit http://www.createconvert.com" dimensions:CGSizeMake(428,250) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:12];
        
        lblContent.position =  ccp( 240, 90);

        lblContent.color=ccc3(0,0,0);
        [self addChild: lblContent];
        
        // Add the menu to the layer
        [self addChild:menu];

    }
    
    return self;
}
-(void) dealloc{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
