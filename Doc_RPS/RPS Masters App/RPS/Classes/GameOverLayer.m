//
//  GameOverLayer.m
//  RPS
//
//  Created by chibitotoro on 12-05-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "MainMenuLayer.h"
#import "SinglePlayerVersusLayer.h"
#import "SimpleAudioEngine.h"
@implementation GameOverLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	GameOverLayer *layer = [GameOverLayer node];
	[scene addChild: layer];
	
	return scene;
}

-(void) dealloc{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
-(id)init{
    
    if((self=[super init])){
        
        [self schedule:@selector(nextFrame:)];  // schedule a repeating callback on every frame
        
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
        //game over music
        if(ad.playingBGM) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"GameOver.mp3"];
        

        
        sprBackground=[CCSprite spriteWithFile:@"game-over-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        itmReturn=[CCMenuItemImage itemWithNormalImage:@"game-over-no.png" 
                                        selectedImage:@"game-over-no.png" 
                                                block:^(id sender) {
                                                    if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                    [self returnCallback];
                                                }]; 
        itmReturn.position=ccp(54,68);
        itmContinue=[CCMenuItemImage itemWithNormalImage:@"game-over-yes.png" 
                                         selectedImage:@"game-over-yes.png" 
                                                 block:^(id sender) {
                                                     if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                     ad.restarted=true;
                                                    [[SimpleAudioEngine sharedEngine]stopEffect:eftCountdown];
                                                     [[CCDirector sharedDirector] replaceScene:
                                                      [CCTransitionFade transitionWithDuration:0.5f scene:[SinglePlayerVersusLayer scene]]];
                                                 }]; 
        itmContinue.position=ccp(426,68);
        
        
        menu = [CCMenu menuWithItems:itmReturn,itmContinue,nil];
        [menu setPosition:ccp( 0, 0)];
        [self addChild:menu];
        
        lblTimer=[CCLabelTTF labelWithString:@"10" fontName:@"Corpulent Caps (BRK)" fontSize:100];
        lblTimer.position=ccp(380,150);
        [self addChild:lblTimer];
        lblContinue=[CCLabelTTF labelWithString:@"Continue?" fontName:@"Corpulent Caps (BRK)" fontSize:29];
        lblContinue.position=ccp(380,210);
        [self addChild:lblContinue];
        
        
        timer=10;
        transitioning=false;
        
    }
    return self;
}

- (void) nextFrame:(ccTime)dt {
    
    float nextTimer=timer-dt;
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    if((int)timer>(int)nextTimer){
        if(ad.playingSFX){
            eftCountdown=[[SimpleAudioEngine sharedEngine] playEffect:@"CountDown.mp3"];   
        }
    }
    [lblTimer setString:[NSString stringWithFormat:@"0%d",(int)timer]];
    
    timer=nextTimer;
    if(timer<=0){
        [self returnCallback];
    }
    
    
}

-(void) returnCallback{
    if(transitioning) return;
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    ad.restarted=true;  //flag to restart main menu
    
    transitioning=true;
    
    [[SimpleAudioEngine sharedEngine]stopEffect:eftCountdown];
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
}
@end
