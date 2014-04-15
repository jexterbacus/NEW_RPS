//
//  MainMenuLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "CCTouchDispatcher.h"
#import "OptionsLayer.h"
#import "SinglePlayerOptionsLayer.h"
#import "MultiplayerOptionsLayer.h"
#import "AboutLayer.h"
#import "HowToPlayLayer.h"

#import "CCUIViewWrapper.h"
#import "SimpleAudioEngine.h"

@implementation MainMenuLayer


#pragma mark - MainMenuLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

#pragma mark TOUCH EVENTS

-(void) registerWithTouchDispatcher
{
    CCDirector *director = [CCDirector sharedDirector];
    [[director touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	//CGPoint location = [self convertTouchToNodeSpace: touch];
}


#pragma mark DRAW FUNCTIONS
- (void) nextFrame:(ccTime)dt {
   
}


#pragma mark INIT
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        self.isTouchEnabled = YES;
        
        //CGSize size = [[CCDirector sharedDirector] winSize];    //get window size
        
        sprBackground=[CCSprite spriteWithFile: @"home-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        sprLogo=[CCSprite spriteWithFile: @"home-logo.png"];
        sprLogo.position=ccp(140,230);
        sprLogo.scale=0.8;
        [self addChild:sprLogo];
        
        
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
                
    
        
        if(ad.playingBGM&&ad.restarted){
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MainMenu.mp3"];
        }

        ad.restarted=false;
        
        //
        // Leaderboards and Achievements
        //
        
        // Default font size will be 28 points.
        [CCMenuItemFont setFontSize:20];
        
        // Achievement Menu Item using blocks
        
        itmAchievement = [CCMenuItemImage itemWithNormalImage:@"achievements-button.png" 
                                          selectedImage:@"achievements-button.png" 
                                                  block:^(id sender) {
                                                      
                                                      if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];  
                                                    
                                                      [ad.mgrGameCenter showAchievements];
                                                      
                                                  }];    
        
    
        itmAchievement.position=ccp(106,120);
        
        // Leaderboard Menu Item using blocks
        itmLeaderboard = [CCMenuItemImage itemWithNormalImage:@"leaderboard-button.png" 
                                                selectedImage:@"leaderboard-button.png" 
                                                        block:^(id sender) {
                                                            
                                                             if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                           
                                                            [ad.mgrGameCenter showLeaderboardForCategory:@"1"];
                                                            
                                                        }];
        itmLeaderboard.position=ccp(106,65);
        
        
        // Single Player Button
        itmSinglePlayer = [CCMenuItemImage itemWithNormalImage:@"single-player-button.png" 
                                         selectedImage:@"single-player-button.png" 
                                                 block:^(id sender) {
                                                     if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                     
                                                     [[CCDirector sharedDirector] replaceScene:
                                                      [CCTransitionFade transitionWithDuration:0.5f scene:[SinglePlayerOptionsLayer scene]]];
                                                     
                                                     

                                                 }];    
        
        itmSinglePlayer.position=ccp(385,285);
        
        // Multiplayer Button
        itmMultiplayer = [CCMenuItemImage itemWithNormalImage:@"multiplayer-button.png" 
                                                 selectedImage:@"multiplayer-button.png" 
                                                         block:^(id sender) {
  
                                                              if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                             
                                                             if(ad.mgrGameCenter.localPlayer.alias.length>0){
                                                                 [[CCDirector sharedDirector] replaceScene:
                                                                  [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerOptionsLayer scene]]];
                                                             }
                                                             else{
                                                                 UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Game Center Required" message:@"Please sign into game center to use this feature." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                                                                 [alert show];

                                                             }
                                                         }];    
        
        itmMultiplayer.position=ccp(385,230);
        
        // Option Button
        itmOptions = [CCMenuItemImage itemWithNormalImage:@"options-button.png" 
                                                selectedImage:@"options-button.png" 
                                                        block:^(id sender) {
                                                            
                                                            if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                            [[CCDirector sharedDirector] replaceScene:
                                                             [CCTransitionFade transitionWithDuration:0.5f scene:[OptionsLayer scene]]];
                                                            
                                                        }];    
        
        itmOptions.position=ccp(385,175);
        
        // How to Play Button
        itmHowToPlay = [CCMenuItemImage itemWithNormalImage:@"how-to-play-button.png" 
                                            selectedImage:@"how-to-play-button.png" 
                                                    block:^(id sender) {
                                                        
                                                        if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                        
                                                        [[CCDirector sharedDirector] replaceScene:
                                                         [CCTransitionFade transitionWithDuration:0.5f scene:[HowToPlayLayer scene]]];
                                                        
                                                    }];    
        
        itmHowToPlay.position=ccp(385,120);
        
        // About Button
        itmAbout = [CCMenuItemImage itemWithNormalImage:@"about-button.png" 
                                            selectedImage:@"about-button.png" 
                                                    block:^(id sender) {
                                                        
                                                        if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                        [[CCDirector sharedDirector] replaceScene:
                                                         [CCTransitionFade transitionWithDuration:0.5f scene:[AboutLayer scene]]];
                                                        
                                                    }];    
        
        itmAbout.position=ccp(385,65);
        
        
        
    
        
        menu = [CCMenu menuWithItems:itmSinglePlayer,itmMultiplayer,itmOptions,itmHowToPlay,itmAbout,itmAchievement, itmLeaderboard, nil];

        [menu setPosition:ccp( 0, 0)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}




@end
