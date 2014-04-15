//
//  SinglePlayerChallengerLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SinglePlayerVersusLayer.h"
#import "SinglePlayerBattleLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation SinglePlayerVersusLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	SinglePlayerVersusLayer *layer = [SinglePlayerVersusLayer node];
	[scene addChild: layer];
	
	return scene;
}
- (void) nextFrame:(ccTime)dt {
    timer-=dt;
    if(timer<=0) timer=0;
    
    if(timer==0&&!transitioning){

        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5f scene:[SinglePlayerBattleLayer scene]]];

        transitioning=true;
    }
}
-(id)init{
    if((self=[super init])){
        
        transitioning=false;
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];

        [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];

        
//        if(ad.playingBGM&&ad.restarted){
        if(ad.playingBGM){
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MainMenu.mp3"];
        }
        
        ad.restarted=false;
        
        sprBackground=[CCSprite spriteWithFile:@"versus-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        sprSpeedLinesTop=[CCSprite spriteWithFile:@"speed-lines.png"];
        sprSpeedLinesTop.position=ccp(240,238);
        [self addChild:sprSpeedLinesTop];
        
        sprSpeedLinesBottom=[CCSprite spriteWithFile:@"speed-lines.png"];
        sprSpeedLinesBottom.position=ccp(240,113);
        sprSpeedLinesBottom.scaleX=-1;
        [self addChild:sprSpeedLinesBottom];
        

        //opponents character
        switch(ad.rightCharacter){
            case BOY:
                ad.chrRight=[[Boy alloc]init];
                break;
            case GIRL:
                ad.chrRight=[[Girl alloc]init];
                break;
            case ROBOT:
                ad.chrRight=[[Robot alloc]init];
                break;
            case SNOWMAN:
                ad.chrRight=[[Snowman alloc]init];
                break;
            case DOG:
                ad.chrRight=[[Dog alloc]init];
                break;
            default:
                break;
        }
        
        //user's character
        switch(ad.selectedCharacter){
            case BOY:
                ad.chrLeft=[[Boy alloc]init];
                break;
            case GIRL:
                ad.chrLeft=[[Girl alloc]init];
                break;
            case ROBOT:
                ad.chrLeft=[[Robot alloc]init];
                break;
            case SNOWMAN:
                ad.chrLeft=[[Snowman alloc]init];
                break;
            case DOG:
                ad.chrLeft=[[Dog alloc]init];
                break;
            default:
                break;
        }

        //label bgs
        
        sprTopLabel = [CCSprite spriteWithFile:@"versus-top-label.png"];
        sprTopLabel.position=ccp(98,303);
        [self addChild:sprTopLabel];
        
        sprBottomLabel = [CCSprite spriteWithFile:@"versus-bottom-label.png"];
        sprBottomLabel.position=ccp(382,49);
        [self addChild:sprBottomLabel];
        
        int posX,posY;
        
        //LEFT CHARACTER INFO =========================
        
        //left character name
        lblLeft=[CCLabelTTF labelWithString:ad.chrLeft.name fontName:@"ComixHeavy" fontSize:16];
        lblLeft.position=ccp(90,303);
        [self addChild:lblLeft];
        
        posX=100;
        posY=160;
        
        ad.chrLeft.sprVSAvatar.position=ccp(130,238);
        [self addChild:ad.chrLeft.sprVSAvatar];
        
        
        
        //RIGHT CHARACTER INFO ===========================
        
        posX=380;
        posY=160;
        //Right 
        lblRight=[CCLabelTTF labelWithString:ad.chrRight.name fontName:@"ComixHeavy" fontSize:16];
        lblRight.position=ccp(390,49);
        [self addChild:lblRight];
        
        ad.chrRight.sprVSAvatar.scaleX=-1;
        ad.chrRight.sprVSAvatar.position=ccp(350,113);
        [self addChild:ad.chrRight.sprVSAvatar];
                
        //VS Label in center
        sprVersus=[CCSprite spriteWithFile:@"versus.png"];
        sprVersus.position=ccp(240,176);
        [self addChild:sprVersus];
        
        timer=3;
        
        [self schedule:@selector(nextFrame:)];  // schedule a repeating callback on every frame
        
        
    }
    
    return self;
}
-(void)onEnterTransitionDidFinish {
	[super onEnterTransitionDidFinish];
    //AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    //reset match parameters
}

-(void) dealloc{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];

    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
