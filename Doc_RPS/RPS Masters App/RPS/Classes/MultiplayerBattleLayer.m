//
//  MultiplayerBattleLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiplayerBattleLayer.h"
#import "MultiplayerOptionsLayer.h"
#import "MultiplayerVersusLayer.h"
#import "AppDelegate.h"
#import "CCTouchDispatcher.h"
#import "time.h"
#import "SimpleAudioEngine.h"

#pragma mark - MultiplayerBattleLayer


float entryTime;
float lastChanged;

@implementation MultiplayerBattleLayer
@synthesize sceneState,timer,transitioning;
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	MultiplayerBattleLayer *layer = [MultiplayerBattleLayer node];
	[scene addChild: layer];
	
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
}



#pragma mark DRAW FUNCTIONS
-(void) updateRightHand:(int)hand{
    
    CCTexture2D* tex;
    
    switch (hand) {
        case ROCK:
            [[CCTextureCache sharedTextureCache] removeTexture: [rightHand texture]];
            tex = [[CCTextureCache sharedTextureCache] addImage:@"rock.png"];
            [rightHand setTexture: tex];
            rightHand.scaleX=-1;
            break;
        case PAPER:
            [[CCTextureCache sharedTextureCache] removeTexture: [rightHand texture]];
            tex = [[CCTextureCache sharedTextureCache] addImage:@"paper.png"];
            [rightHand setTexture: tex];
            rightHand.scaleX=-1;
            break;
        case SCISSORS:
            [[CCTextureCache sharedTextureCache] removeTexture: [rightHand texture]];
            tex = [[CCTextureCache sharedTextureCache] addImage:@"scissors.png"];
            [rightHand setTexture: tex];
            rightHand.scaleX=-1;
            break;
        default:
            break;
    }
}

-(void) updateLeftHand:(int)hand{
    
    CCTexture2D* tex;
    
    switch (hand) {
        case ROCK:
            [[CCTextureCache sharedTextureCache] removeTexture: [leftHand texture]];
            tex = [[CCTextureCache sharedTextureCache] addImage:@"rock.png"];
            [leftHand setTexture: tex];
            leftHand.scaleX=1;
            break;
        case PAPER:
            [[CCTextureCache sharedTextureCache] removeTexture: [leftHand texture]];
            tex = [[CCTextureCache sharedTextureCache] addImage:@"paper.png"];
            [leftHand setTexture: tex];
            leftHand.scaleX=1;
            break;
        case SCISSORS:
            [[CCTextureCache sharedTextureCache] removeTexture: [leftHand texture]];
            tex = [[CCTextureCache sharedTextureCache] addImage:@"scissors.png"];
            [leftHand setTexture: tex];
            leftHand.scaleX=1;
            break;
        default:
            break;
    }
}


#pragma mark AI Logic

-(void) determineResult{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    if(ad.userHand==ad.opponentHand){
        
        //tie conditional ====================
        sprTie.visible=true;
        [record appendString:@"T"];
        
        if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"RoundTie.mp3"]; 
    }
    else{
        
        //apply badges
        
        CCSprite * userBadge;
        CCSprite * opponentBadge;
        
        bool win=false;
        
        if(ad.currentStage==CASINO){
            Casino * casino;
            casino=(Casino *)ad.mgrStage.stgCurrent;
            [casino.sign roundWin];
        }
        
        if((ad.userHand==ROCK&&ad.opponentHand==SCISSORS)||
           (ad.userHand==PAPER&&ad.opponentHand==ROCK)||
           (ad.userHand==SCISSORS&&ad.opponentHand==PAPER)){
            
            win=true;
            
            
        }
        id action;
        
        if(win){
            //user win conditional =====================
            
            sprWin.visible=true;
            
            [record appendString:@"W"];
            if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"RoundWin.mp3"];
            
            
            if(ad.userHand==ROCK){
                userBadge=[CCSprite spriteWithFile: @"rock-win.png"];
                opponentBadge=[CCSprite spriteWithFile:@"scissors-lose.png"];
            }
            else if(ad.userHand==PAPER){
                userBadge=[CCSprite spriteWithFile: @"paper-win.png"];
                opponentBadge=[CCSprite spriteWithFile:@"rock-lose.png"];
            }
            else if(ad.userHand==SCISSORS){
                userBadge=[CCSprite spriteWithFile: @"scissors-win.png"];
                opponentBadge=[CCSprite spriteWithFile:@"paper-lose.png"];
            }
            
            winCount++;
            action=[CCSpawn actions:
                      [CCScaleTo actionWithDuration:1 scaleX:1-(winCount/ceil(ad.numberOfRounds/2.f)) scaleY:1],
                      [CCBlink actionWithDuration:1 blinks:10],
                      nil];

            
            if(ad.currentStage==CASINO){
                Casino * casino;
                casino=(Casino *)ad.mgrStage.stgCurrent;
                [casino.slotRight roundWin];
            }
        }
        else{
            //lose conditional =======================
            
            sprLose.visible=true;
            [record appendString:@"L"];
            if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"RoundLose.mp3"]; 
            if(ad.userHand==ROCK){
                userBadge=[CCSprite spriteWithFile: @"rock-lose.png"];
                opponentBadge=[CCSprite spriteWithFile:@"paper-win.png"];
            }
            else if(ad.userHand==PAPER){
                userBadge=[CCSprite spriteWithFile: @"paper-lose.png"];
                opponentBadge=[CCSprite spriteWithFile:@"scissors-win.png"];
            }
            else if(ad.userHand==SCISSORS){
                userBadge=[CCSprite spriteWithFile: @"scissors-lose.png"];
                opponentBadge=[CCSprite spriteWithFile:@"rock-win.png"];
            }
            
            
            loseCount++;
            action= [CCSpawn actions:
                     [CCScaleTo actionWithDuration:1 scaleX:1-(loseCount/ceil(ad.numberOfRounds/2.f)) scaleY:1],
                     [CCBlink actionWithDuration:1 blinks:10],
                     nil];

            if(ad.currentStage==CASINO){
                Casino * casino;
                casino=(Casino *)ad.mgrStage.stgCurrent;
                [casino.slotRight roundLose];
            }
        }
        
        //animate hp depleting
                 
        id ease = [CCEaseOut actionWithAction:action rate:1];
        
        if(ad.userSide==LEFT_SIDE){
            userBadge.position=ccp(193-(ad.currentRound-1)*19,283);
            opponentBadge.position=ccp(((ad.currentRound-1)*19)+287,283);
        }
        else{
            userBadge.position=ccp(((ad.currentRound-1)*19)+287,283);
            opponentBadge.position=ccp(193-(ad.currentRound-1)*19,283);
        }
        
        if((ad.userSide==LEFT_SIDE&&win)||(ad.userSide==RIGHT_SIDE&&!win)){
            [ad.mgrStage.stgCurrent.sprRightLife runAction: ease];
            [ad.chrLeft roundWin];
            [ad.chrRight roundLose];
        }
        else{
            [ad.mgrStage.stgCurrent.sprLeftLife runAction: ease];
            [ad.chrLeft roundLose];
            [ad.chrRight roundWin];
            
           

        }
        
        ad.currentRound++;
        
        [baseLayer addChild:userBadge];
        [baseLayer addChild:opponentBadge];
        
        [roundBadges addObject:userBadge];
        [roundBadges addObject:opponentBadge];
    }
}

-(void) resetMatch{
    for(int i=0;i<[roundBadges count];i++){
        [self removeChild:(CCSprite*)[roundBadges objectAtIndex:i] cleanup:YES];
    }
    winCount=loseCount=0;
    timer=2;
    
    if(record!=NULL) [record release];
    record=[[NSMutableString alloc] initWithString:@""];
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    ad.mgrStage.stgCurrent.sprLeftLife.scaleX=1;
    ad.mgrStage.stgCurrent.sprRightLife.scaleX=1;
    
    [ad.chrLeft idle];
    [ad.chrRight idle];
}

-(void) showWinScreen{
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    //make the winning overlay layer visible
    winLayer.visible=true;
    bubbleLayer.visible=true;
    

    switch (ad.userSide) {
        case LEFT_SIDE:
            ad.chrLeft.sprWin.position=ccp(160,160);
            sprWinBackground.scaleX=1;
            [winLayer addChild:ad.chrLeft.sprWin];
            if(ad.playingBGM) winEffect=[[SimpleAudioEngine sharedEngine] playEffect:ad.chrLeft.winEffect];            
            lblWinText=[CCLabelTTF labelWithString:ad.chrLeft.winLine dimensions:CGSizeMake(420,60) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:16];
            break;
        case RIGHT_SIDE:
            ad.chrRight.sprWin.position=ccp(320,160);
            ad.chrRight.sprWin.scaleX=-1;
            sprWinBackground.scaleX=-1;
            [winLayer addChild:ad.chrRight.sprWin];
            if(ad.playingBGM) winEffect=[[SimpleAudioEngine sharedEngine] playEffect:ad.chrRight.winEffect];
            lblWinText=[CCLabelTTF labelWithString:ad.chrRight.winLine dimensions:CGSizeMake(420,60) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:16];

            break;
        default:
            break;
    }
    NSLog(@"GG1");
    //win text
    
    lblWinText.color=ccc3(0,0,0);
    lblWinText.position=ccp(240,60);
    [bubbleLayer addChild:lblWinText];
}

-(void) showLoseScreen{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    winLayer.visible=true;
    bubbleLayer.visible=true;
    
    

    
    switch (ad.userSide) {
        case LEFT_SIDE:
            ad.chrRight.sprWin.position=ccp(320,160);
            ad.chrRight.sprWin.scaleX=-1;
            sprWinBackground.scaleX=-1;
            [winLayer addChild:ad.chrRight.sprWin];
            if(ad.playingBGM) winEffect=[[SimpleAudioEngine sharedEngine] playEffect:ad.chrRight.winEffect];
            lblWinText=[CCLabelTTF labelWithString:ad.chrRight.winLine dimensions:CGSizeMake(420,60) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:16];
            break;
        case RIGHT_SIDE:
            ad.chrLeft.sprWin.position=ccp(160,160);
            sprWinBackground.scaleX=1;
            [winLayer addChild:ad.chrLeft.sprWin];
            if(ad.playingBGM) winEffect=[[SimpleAudioEngine sharedEngine] playEffect:ad.chrLeft.winEffect];
            lblWinText=[CCLabelTTF labelWithString:ad.chrLeft.winLine dimensions:CGSizeMake(420,60) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:16];
            break;
        default:
            break;
    }
    NSLog(@"GG2");
    //win text
    
    lblWinText.color=ccc3(0,0,0);
    lblWinText.position=ccp(240,60);
    [bubbleLayer addChild:lblWinText];
    

}

- (void) nextFrame:(ccTime)dt {
//            NSLog(@"FRAME");
    NSNumber * nbrTimer;
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
    
    
    
    if(sceneState!=PAUSED){
        timer-=dt;                  //decrement timer
        if(timer<=0) timer=0;       //if timer is <0 set to 0 for exit condition
    }
    
    if(ad.isHost&&syncTimer<=0){   
        [ad.mgrGameCenter sendPacket:SYNC_PACKET state:sceneState character:0 data:0 time:timer];
        syncTimer=1;        //send out a ping packet every second as host
    }
    syncTimer-=dt;
    
    switch (sceneState) {
        case READY:
            if(timer<=0){
                timer=2;
                sceneState=GO;
                sprReady.visible=false;
                sprGo.visible=true;
                if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Go.mp3"]; 
            }
            break;
            
        case GO:
            if(timer<=0){
                timer=roundTime;
                sceneState=IN_BATTLE;
                sprGo.visible=false;
                menu.visible=true;
            }
            break;
        case IN_BATTLE:
            menu.visible=true;
            //lblTimer.visible=true;      //show battle timer
            
            nbrTimer=[NSNumber numberWithInt:floor(timer)];
            [lblTimer setString:[nbrTimer stringValue]];
            
            int subTime=(timer-floor(timer))*100;
            if(subTime<10){
                [lblSubTimer setString:[NSString stringWithFormat:@"0%d",subTime]];
            }
            else {
                [lblSubTimer setString:[NSString stringWithFormat:@"%d",subTime]];
            }
            
            
            
            //change to throwing state if timer hits 0
            if(timer==0){                
                sceneState=THROWING;
                [self updateLeftHand:ROCK];
                [self updateRightHand:ROCK];
                [leftHand runAction: [CCBlink actionWithDuration:3 blinks:3]];
                [rightHand runAction: [CCBlink actionWithDuration:3 blinks:3]];
                timer=2.5f;
                
                //change sprite animations ==========
                [ad.chrLeft jyankenpon];
                [ad.chrRight jyankenpon];
                
                if(ad.currentStage==CASINO){
                    //pull lever
                    Casino * casino;
                    casino=(Casino*)ad.mgrStage.stgCurrent;
                    [casino.lever matchLose];
                }
            }
            break;
        case THROWING:
            menu.visible=false;
            //lblTimer.visible=false;     //hide timer
            
            if(timer==0){  
                
                //change sprite animations ===============
                if(ad.userSide==LEFT_SIDE){
                    switch (ad.userHand) {
                        case ROCK:[ad.chrLeft rock];break;
                        case PAPER:[ad.chrLeft paper];break;
                        case SCISSORS:[ad.chrLeft scissors];break;
                        default:
                            break;
                    }
                    switch (ad.opponentHand) {
                        case ROCK:[ad.chrRight rock];break;
                        case PAPER:[ad.chrRight paper];break;
                        case SCISSORS:[ad.chrRight scissors];break;
                        default:
                            break;
                    }
                    
                    [self updateLeftHand:ad.userHand];
                    [self updateRightHand:ad.opponentHand];
                }
                else{
                    switch (ad.userHand) {
                        case ROCK:[ad.chrRight rock];break;
                        case PAPER:[ad.chrRight paper];break;
                        case SCISSORS:[ad.chrRight scissors];break;
                        default:
                            break;
                    }
                    switch (ad.opponentHand) {
                        case ROCK:[ad.chrLeft rock];break;
                        case PAPER:[ad.chrLeft paper];break;
                        case SCISSORS:[ad.chrLeft scissors];break;
                        default:
                            break;
                    }   
                    [self updateLeftHand:ad.opponentHand];
                    [self updateRightHand:ad.userHand];
                }
                
                timer=2.5f;

                sceneState=THROWN;
                
            }
            break;
        case THROWN:
          
            
            if(timer==0){ 
                //determine win or lose 
                
                [self determineResult];
                
                sceneState=RESULT;
                timer=3;      
            }
            
            break;
        case PAYOUT:
            if(timer==0){
                sprWin.visible=false;
                sprLose.visible=false;
                sprTie.visible=false;
                
                if(winCount==ceil(ad.numberOfRounds/2.f)){
                    
                    
                    //win match
                    sceneState=WIN;
                    
                    //update retained win counter
                    ad.multiplayerWins++;
                    
                    if(ad.multiplayerWins>=10){
                        [ad.mgrGameCenter reportAchievementIdentifier:kAchievementWinMulti10 percentComplete:100.0];
                    }
                    if(ad.multiplayerWins>=100){
                        [ad.mgrGameCenter reportAchievementIdentifier:kAchievementWinMulti100 percentComplete:100.0];
                    }
                    if(ad.multiplayerWins>=500){
                        [ad.mgrGameCenter reportAchievementIdentifier:kAchievementWinMulti500 percentComplete:100.0];
                    }
                    
                    printf("WINS:%d\n",ad.multiplayerWins);
                    // to store
                    [ad.defaults setObject:[NSNumber numberWithInt:ad.multiplayerWins] forKey:@"mpWins"];
                    [ad.defaults synchronize];
                    
                    //update to leaderboards
                    [ad.mgrGameCenter reportScore:ad.multiplayerWins forCategory:@"1"];
                    
                    timer=4;

                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                    
                    NSLog(@"WIN");
                    [self showWinScreen];
                    
                }
                else if(loseCount==ceil(ad.numberOfRounds/2.f)){
                    //lose match
                    sceneState=LOSE;
                    
                    timer=4;

                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic]; 
                    
                    NSLog(@"LOSE");
                    [self showLoseScreen];
                }
            }
            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementPlayMulti1 percentComplete:100.0];
            break;
        case RESULT:
            if(timer==0){
                sprWin.visible=false;
                sprLose.visible=false;
                sprTie.visible=false;
                
                sceneState=PAYOUT;
                if(winCount==ceil(ad.numberOfRounds/2.f)){
                    //win match
                    
                    Restaurant * restaurant;
                    Casino * casino;
                    
                    id jumpAction;
                    id fallAction;
                    
                    id jumpDestination;
                    id fallDestination;
                    
                    //[chrLeft matchWin];
                    switch (ad.userSide) {
                        case LEFT_SIDE:
                            
                            switch(ad.currentStage){
                                case JUNGLE:
                                    jumpDestination = [CCMoveBy actionWithDuration:0.5 position:ccp(-5,10)];
                                    fallDestination = [CCMoveBy actionWithDuration:1.5 position:ccp(-50,-300)];
                                    
                                    jumpAction=[CCEaseOut actionWithAction:[[jumpDestination copy]autorelease] rate:3.0f];
                                    fallAction=[CCEaseIn actionWithAction:[[fallDestination copy]autorelease] rate:3.0f];
                                    
                                    [ad.chrRight fall];
                                    
                                    
                                    [ad.chrRight.sprCharacter runAction:
                                     [CCSequence actions:
                                      jumpAction, fallAction,
                                      nil]];

                                    break;
                                case RESTAURANT:
                                    restaurant=(Restaurant*)ad.mgrStage.stgCurrent;
                                    [restaurant.waitress collectRight];
                                    
                                    [ad.chrRight matchLose];                        
                                    break;
                                case CASINO:
                                    [casino.sign matchLose];
                                    [ad.chrRight matchLose];  
                                    [casino.slotRight matchLose];
                                    [casino.lever matchLose];
                                    break;
                                default:
                                    break;
                            }
                            break;
                        case RIGHT_SIDE:
                            switch(ad.currentStage){
                                case JUNGLE:
                                    jumpDestination = [CCMoveBy actionWithDuration:0.5 position:ccp(5,10)];
                                    fallDestination = [CCMoveBy actionWithDuration:1.5 position:ccp(50,-300)];
                                    
                                    jumpAction=[CCEaseOut actionWithAction:[[jumpDestination copy]autorelease] rate:3.0f];
                                    fallAction=[CCEaseIn actionWithAction:[[fallDestination copy]autorelease] rate:3.0f];
                                    
                                    [ad.chrLeft fall];
                                    
                                    
                                    [ad.chrLeft.sprCharacter runAction:
                                     [CCSequence actions:
                                      jumpAction, fallAction,
                                      nil]];

                                    break;
                                case RESTAURANT:
                                    restaurant=(Restaurant*)ad.mgrStage.stgCurrent;
                                    [restaurant.waitress collectLeft];
                                    
                                    [ad.chrLeft matchLose];                        
                                    break;
                                case CASINO:
                                    [ad.chrLeft matchLose];                        
                                    break;
                                default:
                                    break;
                            }
                            break;
                        default:
                            break;
                    }
                    
                    
                    timer=2;                    
                }
                else if(loseCount==ceil(ad.numberOfRounds/2.f)){
                    Restaurant * restaurant;
                    Casino * casino;
                    id jumpAction;
                    id fallAction;
                    
                    id jumpDestination;
                    id fallDestination;
                    
                    switch (ad.userSide) {
                        case LEFT_SIDE:
                            switch(ad.currentStage){
                                case JUNGLE:
                                    jumpDestination = [CCMoveBy actionWithDuration:0.5 position:ccp(5,10)];
                                    fallDestination = [CCMoveBy actionWithDuration:1.5 position:ccp(50,-300)];
                                    
                                    jumpAction=[CCEaseOut actionWithAction:[[jumpDestination copy]autorelease] rate:3.0f];
                                    fallAction=[CCEaseIn actionWithAction:[[fallDestination copy]autorelease] rate:3.0f];
                                    
                                    [ad.chrLeft fall];
                                    
                                    
                                    [ad.chrLeft.sprCharacter runAction:
                                     [CCSequence actions:
                                      jumpAction, fallAction,
                                      nil]];

                                    break;
                                case RESTAURANT:
                                    restaurant=(Restaurant*)ad.mgrStage.stgCurrent;
                                    [restaurant.waitress collectLeft];
                                    
                                    [ad.chrLeft matchLose];                        
                                    break;
                                case CASINO: 
                                    casino=(Casino *)ad.mgrStage.stgCurrent;
                                    [casino.sign matchLose];
                                    [ad.chrLeft matchLose];     
                                    [casino.slotRight matchLose];
                                    [casino.lever matchLose];
                                    break;
                                default:
                                    break;
                            }
                            break;
                        case RIGHT_SIDE:
                            switch(ad.currentStage){
                                case JUNGLE:
                                    jumpDestination = [CCMoveBy actionWithDuration:0.5 position:ccp(-5,10)];
                                    fallDestination = [CCMoveBy actionWithDuration:1.5 position:ccp(-50,-300)];
                                    
                                    jumpAction=[CCEaseOut actionWithAction:[[jumpDestination copy]autorelease] rate:3.0f];
                                    fallAction=[CCEaseIn actionWithAction:[[fallDestination copy]autorelease] rate:3.0f];
                                    
                                    [ad.chrRight fall];
                                    
                                    
                                    [ad.chrRight.sprCharacter runAction:
                                     [CCSequence actions:
                                      jumpAction, fallAction,
                                      nil]];

                                    break;
                                case RESTAURANT:
                                    restaurant=(Restaurant*)ad.mgrStage.stgCurrent;
                                    [restaurant.waitress collectRight];
                                    
                                    [ad.chrRight matchLose];                        
                                    break;
                                case CASINO:
                                    [ad.chrRight matchLose];                        
                                    break;
                                default:
                                    break;
                            }
                            break;
                        default:
                            break;
                    }
                    //[chrRight matchWin]; 
                    
                    timer=2;
                }
                else{
                    timer=roundTime;
                    sceneState=IN_BATTLE;
                    
                    //reset animations ====================
                    
                    if(ad.currentStage==CASINO){
                        //reset slot machines
                        Casino * casino;
                        casino=(Casino *)ad.mgrStage.stgCurrent;
                        [casino.sign idle];
                        [casino.slotRight idle];
                        [casino.lever idle];
                    }
                    
                    [ad.chrLeft idle];
                    [ad.chrRight idle];
                    
                    
                }
            }
            break;
        case GAME_OVER:
            break;
        case WIN:
            if(timer==0&&!transitioning){
                [self showRematch];
            }
            break;
        case LOSE:
            if(timer==0){
                [self showRematch];
            }
            break;
        case TIE:
            break;
        case PAUSED:
            break;
        default:
            break;
    }
    
    entryTime+=dt;
}


-(void) showRematch{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    sprOverlay.visible=true;
    sprRematchBackground.visible=true;
    menuOverlay.visible=true;
    lblRematch.visible=true;
    sceneState=PAUSED;
}
-(void)nextRoundCallback{
    
    if(transitioning) return;
    
    transitioning=true;
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    //set up new challenger ---------
    ad.currentRound=1;
    
    bubbleLayer.visible=false;
    winLayer.visible=false;
    
    //transition scene

    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerVersusLayer scene]]];
    
}


#pragma mark INIT
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {

        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
        ad.activeLayer=self;
        ad.inGame=true;
        //CGSize size = [[CCDirector sharedDirector] winSize];  //get window size
        
        [self schedule:@selector(nextFrame:)];  // schedule a repeating callback on every frame
        
        self.isTouchEnabled = YES;
        
        baseLayer=[[CCLayer alloc]init];
        winLayer=[[CCLayer alloc]init];
        bubbleLayer=[[CCLayer alloc]init];
        
        transitioning=false;
        syncTimer=0;

        /************************************
         BASE LAYER
         ************************************/
        
        // Stage Draw First =================
        ad.mgrStage.stageIndex=ad.currentStage;
        
        [ad.mgrStage addStage:baseLayer];
        //[ad.mgrStage.stgCurrent addAvatar:baseLayer];
        
        [ad.mgrStage.stgCurrent playBGM];       //start background music
    
        
        //names
        lblLeftName=[CCLabelTTF labelWithString:ad.chrLeft.name dimensions:CGSizeMake(180,20) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:14];
        lblLeftName.position=ccp(160,265);
        [baseLayer addChild:lblLeftName];
        
        lblRightName=[CCLabelTTF labelWithString:ad.chrRight.name dimensions:CGSizeMake(180,20) alignment:CCTextAlignmentRight fontName:@"Corpulent Caps (BRK)" fontSize:14];
        lblRightName.position=ccp(320,265);        
        [baseLayer addChild:lblRightName];
        
        //Hands ===========================
        leftHand = [CCSprite spriteWithFile: @"rock.png"];
        leftHand.position = ccp( 80, 160 );
        [baseLayer addChild:leftHand];
        
        rightHand = [CCSprite spriteWithFile: @"rock.png"];
        rightHand.position = ccp( 400, leftHand.position.y );
        rightHand.scaleX=-1;
        [baseLayer addChild:rightHand];
        
        
        switch (ad.currentStage){
            case CASINO:
            case RESTAURANT:
                [ad.chrLeft addCharacterToLayer:baseLayer atX:90 atY:90 isFlipped:NO];
                [ad.chrRight addCharacterToLayer:baseLayer atX:390 atY:90 isFlipped:YES];
                
                break;
            case JUNGLE:
                [ad.chrLeft addCharacterToLayer:baseLayer atX:110 atY:110 isFlipped:NO];
                [ad.chrRight addCharacterToLayer:baseLayer atX:370 atY:110 isFlipped:YES];
                
                break;
        }
        
        //Timer ===========================
        
        NSNumber * nbrTimer=[NSNumber numberWithInt:timer];
        lblTimer=[CCLabelTTF labelWithString:[nbrTimer stringValue] fontName:@"Corpulent Caps (BRK)" fontSize:20];
        lblTimer.position=ccp(229,293);
        [baseLayer addChild:lblTimer];     
        
        lblColon=[CCLabelTTF labelWithString:[nbrTimer stringValue] fontName:@"Corpulent Caps (BRK)" fontSize:20];
        [lblColon setString:@":"];
        lblColon.position=ccp(240,293);
        [baseLayer addChild:lblColon];    
        
        lblSubTimer=[CCLabelTTF labelWithString:[nbrTimer stringValue] fontName:@"Corpulent Caps (BRK)" fontSize:12];
        lblSubTimer.position=ccp(252,296);
        [baseLayer addChild:lblSubTimer];
        
        //Rock Button ========================
        itmRock = [CCMenuItemImage itemWithNormalImage:@"rock-button.png" 
                                         selectedImage:@"rock-button.png" 
                                                 block:^(id sender) {
                                                     
                                                     if(sceneState==IN_BATTLE){
                                                         if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                         
                                                         
                                                         [ad.mgrGameCenter sendPacket:HAND_PACKET state:sceneState character:ad.userSide data:ROCK time:timer];
                                                         
                                                         
                                                         ad.userHand=ROCK;
                                                         
                                                         if(ad.userSide==LEFT_SIDE){
                                                             [self updateLeftHand:ROCK];
                                                         }
                                                         else{
                                                             [self updateRightHand:ROCK];
                                                         }
                                                     }
                                                 }];
        itmRock.opacity=150;
        itmRock.position=ccp(240,170);
        
        //Paper Button ========================
        itmPaper = [CCMenuItemImage itemWithNormalImage:@"paper-button.png" 
                                          selectedImage:@"paper-button.png" 
                                                  block:^(id sender) {
                                                      if(sceneState==IN_BATTLE){
                                                          if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                          
                                                          [ad.mgrGameCenter sendPacket:HAND_PACKET state:sceneState character:ad.userSide data:PAPER time:timer];
                                                          
                                                          ad.userHand=PAPER;
                                                          if(ad.userSide==LEFT_SIDE){
                                                              [self updateLeftHand:PAPER];
                                                          }
                                                          else{
                                                              [self updateRightHand:PAPER];
                                                          }
                                                        
                                                      }
                                                  }];
        itmPaper.position=ccp(190,88);
        itmPaper.opacity=150;
        
        
        
        //Scissor Button ========================
        itmScissor =  [CCMenuItemImage itemWithNormalImage:@"scissors-button.png" 
                                             selectedImage:@"scissors-button.png" 
                                                     block:^(id sender) {
                                                         if(sceneState==IN_BATTLE){
                                                             if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];  
                                                             
                                                             [ad.mgrGameCenter sendPacket:HAND_PACKET state:sceneState character:ad.userSide data:SCISSORS time:timer];
                                                             
                                                             ad.userHand=SCISSORS;
                                                             if(ad.userSide==LEFT_SIDE){
                                                                 [self updateLeftHand:SCISSORS];
                                                             }
                                                             else{
                                                                 [self updateRightHand:SCISSORS];
                                                             }
                                                            
                                                         }
                                                     }];  
        itmScissor.position=ccp(290,88);
        itmScissor.opacity=150;
                
        if(ad.userSide==RIGHT_SIDE){
            itmRock.scaleX=-1;
            itmPaper.scaleX=-1;
            itmScissor.scaleX=-1;
        }
        // MENU ============================
        menu = [CCMenu menuWithItems:itmRock,itmPaper, itmScissor,itmPause,nil];
        [menu setPosition:ccp( 0, 0)];
        menu.visible=false;
        [baseLayer addChild:menu];
        
        
        [self addChild:baseLayer];
        
        sprWin=[CCSprite spriteWithFile:@"you-win.png"];
        sprWin.scale=0.7;
        sprWin.position=ccp(240,160);
        sprWin.visible=false;
        [baseLayer addChild:sprWin];
        
        sprTie=[CCSprite spriteWithFile:@"tie.png"];
        sprTie.scale=0.7;
        sprTie.position=ccp(240,160);
        sprTie.visible=false;
        [baseLayer addChild:sprTie];
        
        sprLose=[CCSprite spriteWithFile:@"you-lose.png"];
        sprLose.scale=0.7;
        sprLose.position=ccp(240,160);
        sprLose.visible=false;
        [baseLayer addChild:sprLose];
        
        
        // READY & GO
        sprReady=[CCSprite spriteWithFile:@"ready.png"];
        sprReady.position=ccp(240,160);
        [baseLayer addChild:sprReady];
        if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Ready.mp3"]; 
        
        sprGo=[CCSprite spriteWithFile:@"go.png"];
        sprGo.visible=false;
        sprGo.position=ccp(240,160);
        [baseLayer addChild:sprGo];
        
        /************************************
         WIN LAYER
         ************************************/
        
        sprWinBackground=[CCSprite spriteWithFile:@"win-bg.png"];
        sprWinBackground.position=ccp(240,160);
        [winLayer addChild:sprWinBackground];
        
        winLayer.visible=false;
        [self addChild:winLayer];
        
        
        sprTextBubble=[CCSprite spriteWithFile:@"text-bubble.png"];
        sprTextBubble.position=ccp(240,74);
        
        [bubbleLayer addChild:sprTextBubble];
        
        bubbleLayer.visible=false;
        [self addChild:bubbleLayer];
        
        /************************************
         OVERLAY LAYER
         ************************************/
        // overlay =======================
        sprOverlay=[CCSprite spriteWithFile:@"modal-overlay.png"];
        sprOverlay.position=ccp(240,160);
        [self addChild:sprOverlay];
        sprOverlay.visible=false;
        
        sprRematchBackground=[CCSprite spriteWithFile:@"pause-bg.png"];
        sprRematchBackground.position=ccp(240,196);
        [self addChild:sprRematchBackground];
        sprRematchBackground.visible=false;
        
        //Return Button ===============
        itmReturn = [CCMenuItemImage itemWithNormalImage:@"back.png" 
                                           selectedImage:@"back.png" 
                                                   block:^(id sender) {
                                                       ad.restarted=true;
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];   
                                                       
                                                       [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MainMenu.mp3"];
                                                       
                                                    
//                                                     [self resetMatch];
                                                       
                                                       [ad.mgrGameCenter disconnect];
                                                       /*
                                                       [[CCDirector sharedDirector] replaceScene:
                                                        [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerOptionsLayer scene]]];
                                                       */
                                                   }];
        itmReturn.position=ccp(93,190);
        
        itmRematch = [CCMenuItemImage itemWithNormalImage:@"rematch.png" 
                                           selectedImage:@"rematch.png" 
                                                   block:^(id sender) {
                                                       ad.restarted=true;
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];
                                                    //[self resetMatch];
                                                       [self nextRoundCallback];
                                                       
                                                   }];
        itmRematch.position=ccp(407,190);
        
        menuOverlay=[CCMenu menuWithItems:itmReturn,itmRematch,nil];
        [menuOverlay setPosition:ccp( 0, 0)];
        [self addChild:menuOverlay];
        menuOverlay.visible=false;

        // initial battle values ==========================
        entryTime=0;
        lastChanged=0;
        
        roundTime=5;
        
        ad.opponentHand=ROCK;
        ad.userHand=ROCK;
        sceneState=READY;
        
        [lblTimer setString:[NSString stringWithFormat:@"%d",roundTime]];
        [lblSubTimer setString:@"00"];
        
        record=[[NSMutableString alloc] initWithString:@""];
        
        roundBadges=[[NSMutableArray alloc]init];
        [self resetMatch];
        
        lblRematch=[CCLabelTTF labelWithString:@"Rematch?" fontName:@"ComixHeavy" fontSize:33];
        lblRematch.position=ccp(240,280);
        lblRematch.visible=false;
        [self addChild:lblRematch]; 
        
	}
	return self;
}
-(void)onEnterTransitionDidFinish {
	[super onEnterTransitionDidFinish];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
   
    [ad.mgrStage.stgCurrent release];
    
    if(roundBadges!=nil){
        [roundBadges release];
    }
    if(record!=nil){
        [record release];
    }
    [baseLayer release];
    [bubbleLayer release];
    [winLayer release];
    
    //[ad.chrLeft release];
    //[ad.chrRight release];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[super dealloc];
}

@end