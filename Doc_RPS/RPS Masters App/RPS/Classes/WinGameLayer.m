//
//  WinGameLayer.m
//  RPS
//
//  Created by chibitotoro on 12-05-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WinGameLayer.h"
#import "MainMenuLayer.h"
#import "Boy.h"
#import "Girl.h"
#import "Robot.h"
#import "Snowman.h"
#import "Dog.h"
#import "SimpleAudioEngine.h"
@implementation WinGameLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	WinGameLayer *layer = [WinGameLayer node];
	[scene addChild: layer];
	
	return scene;
}


-(id)init{
    
    if((self=[super init])){
        sprBackground=[CCSprite spriteWithFile:@"win-game-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        transitioning=false;
        
        itmReturn=[CCMenuItemImage itemWithNormalImage:@"return-home.png" 
                                           selectedImage:@"return-home.png" 
                                                   block:^(id sender) {
                                                       [self returnCallback];
                                                   }]; 
        itmReturn.position=ccp(93,58);
        
        
        menu = [CCMenu menuWithItems:itmReturn,nil];
        [menu setPosition:ccp( 0, 0)];
        [self addChild:menu];
        
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        printf("NULLC:%d\n",ad.chrRight==nil);        
        //Win music
        if(ad.playingBGM){
            winEffect=[[SimpleAudioEngine sharedEngine] playEffect:@"FinishGame.mp3"];   

            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        
        int posX=240;
        int posY=150;
        switch (ad.leftCharacter) {
            case BOY:
                winCharacter=[[Boy alloc]init];
                posX+=10;
                break;
            case GIRL:
                winCharacter=[[Girl alloc]init];
                break;
            case ROBOT:
                winCharacter=[[Robot alloc]init];
                break;
            case SNOWMAN:
                winCharacter=[[Snowman alloc]init];
                break;
            case DOG:
                winCharacter=[[Dog alloc]init];
                break;
            default:
                break;
        }

        [winCharacter roundWin];
        [winCharacter addCharacterToLayer:self atX:posX atY:posY isFlipped:NO];
        
    }
    return self;
}


-(void) returnCallback{
    if(transitioning) return;
    [[SimpleAudioEngine sharedEngine]stopEffect:winEffect];
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    ad.restarted=true;  //flag to restart main menu
    
    transitioning=true;
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
}

-(void) dealloc{
    [winCharacter release];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end

