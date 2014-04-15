//
//  MultiplayerVersusLayer.m
//  RPS
//
//  Created by chibitotoro on 12-05-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "MultiplayerVersusLayer.h"
#import "MultiplayerBattleLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation MultiplayerVersusLayer
@synthesize transitioning;
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	MultiplayerVersusLayer *layer = [MultiplayerVersusLayer node];
	[scene addChild: layer];
	
	return scene;
}
- (void) nextFrame:(ccTime)dt {
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    if((!ad.inGame||ad.disconnected)&&!transitioning){
        
        transitioning=true;
        
        if((!ad.inGame&&ad.isHost)||(!ad.inGame&&!ad.isHost)){
            NSLog(@"Path1");
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Disconnected" message:@"Connection has been terminated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
            [alert show];
            ad.disconnected=true;
            ad.inGame=false;
            
            ad.userReady=false;
            ad.opponentReady=false;
            
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MainMenu.mp3"];
            [[CCDirector sharedDirector] replaceScene:
             [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerOptionsLayer scene]]];
            
            
        }
        else{
            NSLog(@"Path2");
            [ad.mgrGameCenter disconnect];
        }
        
        
    }
    
    timer-=dt;
    if(timer<=0) timer=0;
    
    if(timer==0&&!transitioning){

        transitioning=true;
        ad.userReady=true;
        
        //send ready state change packet and randomly selected stage index
        
        
        //only send if host
        if(ad.isHost){
            ad.currentStage=arc4random()%NUM_STAGES;        //random stage
            
            [ad.mgrGameCenter sendPacket:STATE_PACKET state:READY character:ad.selectedCharacter data:ad.currentStage time:0];
        }
        else{
            [ad.mgrGameCenter sendPacket:STATE_PACKET state:READY character:ad.selectedCharacter data:-1 time:0];
        }
        printf("ENTRY1 : %d,%d\n",ad.userReady,ad.opponentReady);
        if(ad.opponentReady&&ad.userReady){
            [[CCDirector sharedDirector] replaceScene:
             [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerBattleLayer scene]]]; 
        }
    }
}

-(id)init{
    if((self=[super init])){
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        transitioning=false;
        
        ad.inGame=true;
        
        ad.activeLayer=self;
        
        ad.opponentReady=false;
        ad.userReady=false;
        
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
        
        
        
        //label bgs
        
        sprTopLabel = [CCSprite spriteWithFile:@"versus-top-label.png"];
        sprTopLabel.position=ccp(98,303);
        [self addChild:sprTopLabel];
        
        sprBottomLabel = [CCSprite spriteWithFile:@"versus-bottom-label.png"];
        sprBottomLabel.position=ccp(382,49);
        [self addChild:sprBottomLabel];
        
        int posX,posY;
        
        
        //LEFT CHARACTER INFO =========================
        if(ad.userSide==LEFT_SIDE){

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
            
            switch(ad.opponentCharacter){
                default:
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
            }
            ad.leftCharacter=ad.selectedCharacter;
            ad.rightCharacter=ad.opponentCharacter;

           

            ad.chrLeft.name=[NSString stringWithString:ad.mgrGameCenter.localPlayer.alias];
            ad.chrRight.name=[NSString stringWithString:ad.opponentName];

        }
        else{
            
            
            switch(ad.selectedCharacter){
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
            
            switch(ad.opponentCharacter){
                default:
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
            }
            
            ad.leftCharacter=ad.opponentCharacter;
            ad.rightCharacter=ad.selectedCharacter;
            
            ad.chrLeft.name=[NSString stringWithString:ad.opponentName];
            ad.chrRight.name=[NSString stringWithString:ad.mgrGameCenter.localPlayer.alias];
        }
        
        
        //left character name
        lblLeft=[CCLabelTTF labelWithString:ad.chrLeft.name fontName:@"ComixHeavy" fontSize:16];
        lblLeft.position=ccp(90,303);
        [self addChild:lblLeft];
                
        ad.chrLeft.sprVSAvatar.position=ccp(130,238);
        [self addChild:ad.chrLeft.sprVSAvatar];
        
        
        //RIGHT CHARACTER INFO ===========================
        
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
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
