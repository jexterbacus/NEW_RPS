//
//  SinglePlayerBattleLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Import the interfaces
#import "SinglePlayerBattleLayer.h"

#import "AppDelegate.h"
#import "CCTouchDispatcher.h"
#import "time.h"
#import "SimpleAudioEngine.h"

#pragma mark - SinglePlayerBattleLayer


float entryTime;
float lastChanged;

@implementation SinglePlayerBattleLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];	
	SinglePlayerBattleLayer *layer = [SinglePlayerBattleLayer node];
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
	//CGPoint location = [self convertTouchToNodeSpace: touch];
    
    /*
	[cocosGuy stopAllActions];
	[cocosGuy runAction: [CCMoveTo actionWithDuration:0.3 position:location]];    
    */
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
-(void) adversaryLogic:(ccTime)dt{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    lastChanged+=dt;
    switch (ai) {
        case BASIC:
            //change opponent hand logic
            
            if(lastChanged>=0.7){
                ad.opponentHand=arc4random()%3;
                lastChanged-=0.7;
            }
            break;
        case NORMAL:
            if(lastChanged>=0.5){
                ad.opponentHand=arc4random()%3;
                lastChanged-=0.5;
            }
            break;
        case SMART:
            if(lastChanged>=0.3){
                ad.opponentHand=arc4random()%3;
                lastChanged-=0.3;
            }
            break;
        case FAST:
            if(lastChanged>=0.1){
                ad.opponentHand=arc4random()%3;
                lastChanged-=0.1;
            }
            break;
        default:
            break;
    }
    
    /*
    ad.opponentHand=SCISSORS;
    //ad.numberOfRounds=1;
    //ad.currentMatch=4;
    */
    
}

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
        
        CCSprite * leftBadge;
        CCSprite * rightBadge;
        
        if(ad.currentStage==CASINO){
            Casino * casino;
            casino=(Casino *)ad.mgrStage.stgCurrent;
            [casino.sign roundWin];
        }
        
        if((ad.userHand==ROCK&&ad.opponentHand==SCISSORS)||
           (ad.userHand==PAPER&&ad.opponentHand==ROCK)||
           (ad.userHand==SCISSORS&&ad.opponentHand==PAPER)){
            
            //win conditional =====================
            
            sprWin.visible=true;
            
            [record appendString:@"W"];
            if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"RoundWin.mp3"]; 
            if(ad.userHand==ROCK){
                leftBadge=[CCSprite spriteWithFile: @"rock-win.png"];
                rightBadge=[CCSprite spriteWithFile:@"scissors-lose.png"];
            }
            else if(ad.userHand==PAPER){
                leftBadge=[CCSprite spriteWithFile: @"paper-win.png"];
                rightBadge=[CCSprite spriteWithFile:@"rock-lose.png"];
            }
            else if(ad.userHand==SCISSORS){
                leftBadge=[CCSprite spriteWithFile: @"scissors-win.png"];
                rightBadge=[CCSprite spriteWithFile:@"paper-lose.png"];
            }
            
            winCount++;
            
            
            //animate hp depleting
            id action = [CCSpawn actions:
                         [CCScaleTo actionWithDuration:1 scaleX:1-(winCount/ceil(ad.numberOfRounds/2.f)) scaleY:1],
                         [CCBlink actionWithDuration:1 blinks:10],
                         nil];
            
            id ease = [CCEaseOut actionWithAction:action rate:1];
            [ad.mgrStage.stgCurrent.sprRightLife runAction: ease];
            
            
            //sprite animation change =============
            [ad.chrLeft roundWin];
            [ad.chrRight roundLose];
            
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
                leftBadge=[CCSprite spriteWithFile: @"rock-lose.png"];
                rightBadge=[CCSprite spriteWithFile:@"paper-win.png"];
            }
            else if(ad.userHand==PAPER){
                leftBadge=[CCSprite spriteWithFile: @"paper-lose.png"];
                rightBadge=[CCSprite spriteWithFile:@"scissors-win.png"];
            }
            else if(ad.userHand==SCISSORS){
                leftBadge=[CCSprite spriteWithFile: @"scissors-lose.png"];
                rightBadge=[CCSprite spriteWithFile:@"rock-win.png"];
            }
            
            
            loseCount++;
            
            //animate hp depleting
            id action =[CCSpawn actions:
                        [CCScaleTo actionWithDuration:1 scaleX:1-(loseCount/ceil(ad.numberOfRounds/2.f)) scaleY:1],
                        [CCBlink actionWithDuration:1 blinks:10],
                        nil];
            ;
            id ease = [CCEaseOut actionWithAction:action rate:1];
            [ad.mgrStage.stgCurrent.sprLeftLife runAction:ease];   
            
            
            //character sprite change ================
            [ad.chrLeft roundLose];
            [ad.chrRight roundWin];
            
            if(ad.currentStage==CASINO){
                Casino * casino;
                casino=(Casino *)ad.mgrStage.stgCurrent;
                [casino.slotRight roundLose];
            }
        }
        
        leftBadge.position=ccp(193-(ad.currentRound-1)*19,283);
        rightBadge.position=ccp(((ad.currentRound-1)*19)+287,283);
        
        ad.currentRound++;
        
        [baseLayer addChild:leftBadge];
        [baseLayer addChild:rightBadge];
        
        
        [roundBadges addObject:leftBadge];
        [roundBadges addObject:rightBadge];
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
    
    if(ad.playingBGM) winEffect=[[SimpleAudioEngine sharedEngine] playEffect:ad.chrLeft.winEffect];

    ad.chrLeft.sprWin.position=ccp(160,160);
    
    [winLayer addChild:ad.chrLeft.sprWin];
    
    //win text
    lblWinText=[CCLabelTTF labelWithString:ad.chrLeft.winLine dimensions:CGSizeMake(420,60) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:16];
    lblWinText.color=ccc3(0,0,0);
    lblWinText.position=ccp(240,60);
    [bubbleLayer addChild:lblWinText];
}

-(void) showLoseScreen{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    winLayer.visible=true;
    bubbleLayer.visible=true;
    
    if(ad.playingBGM) winEffect=[[SimpleAudioEngine sharedEngine] playEffect:ad.chrRight.winEffect];
    sprWinCharacter=ad.chrRight.sprWin;
    sprWinCharacter.position=ccp(320,160);
    sprWinCharacter.scaleX=-1;
    [winLayer addChild:sprWinCharacter];
    
    //win text
    lblWinText=[CCLabelTTF labelWithString:ad.chrRight.winLine dimensions:CGSizeMake(420,60) alignment:CCTextAlignmentLeft fontName:@"Corpulent Caps (BRK)" fontSize:16];
    lblWinText.color=ccc3(0,0,0);
    lblWinText.position=ccp(240,60);
    [bubbleLayer addChild:lblWinText];
    
    sprWinBackground.scaleX=-1;
    winLayer.visible=true;
    bubbleLayer.visible=true;
}

- (void) nextFrame:(ccTime)dt {

    NSNumber * nbrTimer;
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    if(sceneState!=PAUSED){
        timer-=dt;                  //decrement timer
        if(timer<=0) timer=0;       //if timer is <0 set to 0 for exit condition
    }
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
            
            
            
            // AI ================================
            [self adversaryLogic:dt];       //calculate adversary's hand
            
            [self updateRightHand:ad.opponentHand];     //update opponents current hand after calculating logic
            
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
                                
                timer=2.5f;
                
                sceneState=THROWN;

            }
            break;
        case THROWN:
            if(timer>0.5){
                //show current hands
                [self updateLeftHand:ad.userHand];
                [self updateRightHand:ad.opponentHand];
            }

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
                    ad.singlePlayerWins++;
//                    printf("WINS:%d\n",ad.singlePlayerWins);
                    [ad.defaults setObject:[NSNumber numberWithInt:ad.singlePlayerWins] forKey:@"spWins"];
                    [ad.defaults synchronize];
                    // to store
                    /*
                    //update to leaderboards 
                    [ad.mgrGameCenter reportScore:ad.singlePlayerWins forCategory:@"1"];
                    */
                    
                    timer=4;
                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                    
                    [self showWinScreen];
                    
                    [ad.opponentLineUp removeObjectAtIndex:0];
                    [ad.stageLineUp removeObjectAtIndex:0];
                    
                }
                else if(loseCount==ceil(ad.numberOfRounds/2.f)){
                    //lose match
                    sceneState=LOSE;
                    
                    timer=4;
                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic]; 
                    
                    [self showLoseScreen];
                }
            }
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
                    //[chrLeft matchWin];
                    id jumpDestination;
                    id fallDestination;

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
                            casino=(Casino *)ad.mgrStage.stgCurrent;
                            [casino.sign matchLose];
                            [ad.chrRight matchLose];  
                            [casino.slotRight matchLose];
                            [casino.lever matchLose];
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


                if(ad.currentMatch==4){
                    
                    // FINISHED THE GAME!!!!!!!!!!! --------
                    
                    //do achievements here
                    switch (ad.leftCharacter) {
                        case GIRL:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementSiennaSingleFinish percentComplete:100.0];
                            break;
                        case BOY:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementCharlieSingleFinish percentComplete:100.0];
                            break;
                        case ROBOT:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementSuperUltrabotSingleFinish percentComplete:100.0];
                            break;
                        case SNOWMAN:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementGoomanSingleFinish percentComplete:100.0];
                            break;
                        case DOG:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementK9SingleFinish percentComplete:100.0];
                            break;
                        default:
                            break; 
                    }
                    
                    switch (ad.numberOfRounds) {
                        case THREE_ROUNDS:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementThreesToStart percentComplete:100.0];
                            break;
                        case FIVE_ROUNDS:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementFivesToStart percentComplete:100.0];
                            break;
                        case SEVEN_ROUNDS:
                            [ad.mgrGameCenter reportAchievementIdentifier:kAchievementSevensToStart percentComplete:100.0];
                            break;
                        default:
                            break;
                    }
                    
                    
                    //transition to win screen
                    transitioning=true;
                    [[SimpleAudioEngine sharedEngine]stopEffect:winEffect];
                    
                    
                    [[CCDirector sharedDirector] replaceScene:
                     [CCTransitionFade transitionWithDuration:0.5f scene:[WinGameLayer scene]]];
                    
                }
                else{
                    [self nextRoundCallback];
                }
            }
            break;
        case LOSE:
            if(timer==0){
                
                [self gameOverCallback];
            }
            break;
        case TIE:

            if(timer==0){  

            
                
            }
            break;
        case PAUSED:
            break;
        default:
            break;
    }
    
    entryTime+=dt;
}

-(void) resumeCallback{
     AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    if(sceneState==PAUSED){
        
        sceneState=IN_BATTLE;
        menuOverlay.visible=false;
        lblPaused.visible=false;
        sprOverlay.visible=false;
        sprPauseBackground.visible=false;
        lblBestOf.visible=false;
        lblStage.visible=false;
        lblSFX.visible=false;
        lblMusic.visible=false;
        [ad.mgrStage resume];
    }
}
-(void)nextRoundCallback{

    if(transitioning) return;


    transitioning=true;
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    //set up new challenger ---------
    ad.currentRound=1;
    ad.currentMatch++;
    
    int nextOpponent=[((NSNumber*)[ad.opponentLineUp objectAtIndex:0]) intValue];
    int nextStage=[((NSNumber*)[ad.stageLineUp objectAtIndex:0]) intValue];
    
    ad.rightCharacter=nextOpponent;
    ad.currentStage=nextStage;
    bubbleLayer.visible=false;
    winLayer.visible=false;
    
    //transition scene
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[SinglePlayerVersusLayer scene]]];
}
-(void) gameOverCallback{
    if(transitioning) return;
    transitioning=true;
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    ad.currentRound=1;
    [[SimpleAudioEngine sharedEngine]stopEffect:winEffect];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[GameOverLayer scene]]];
}
-(void) pauseCallback{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    if(sceneState==IN_BATTLE||sceneState==THROWING){
        sprOverlay.visible=true;
        sprPauseBackground.visible=true;
        lblPaused.visible=true;
        lblStage.visible=true;
        lblBestOf.visible=true;
        menuOverlay.visible=true;
        lblSFX.visible=true;
        lblMusic.visible=true;
        
        tempState=sceneState;
        sceneState=PAUSED;
        [ad.mgrStage pause];
    }
    
}
#pragma mark INIT
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
printf("NULLB:%d\n",ad.chrRight==nil);
        //CGSize size = [[CCDirector sharedDirector] winSize];  //get window size
        
        [self schedule:@selector(nextFrame:)];  // schedule a repeating callback on every frame
        
        self.isTouchEnabled = YES;
        
        
        baseLayer=[[CCLayer alloc]init];
        winLayer=[[CCLayer alloc]init];
        bubbleLayer=[[CCLayer alloc]init];
        
        transitioning=false;
        
        /************************************
         BASE LAYER
         ************************************/
        
        // Stage Draw First =================
        ad.mgrStage.stageIndex=ad.currentStage;
        
        [ad.mgrStage addStage:baseLayer];
        
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
                                                          
                                                          ad.userHand=ROCK;
                                                          [self updateLeftHand:ROCK];
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
                                                           ad.userHand=PAPER;
                                                           [self updateLeftHand:PAPER];
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
                                                              ad.userHand=SCISSORS;
                                                              [self updateLeftHand:SCISSORS];
                                                          }
                                                      }];  
        itmScissor.position=ccp(290,88);
        itmScissor.opacity=150;
                
        
        //Pause Button ============================
        itmPause=[CCMenuItemImage itemWithNormalImage:@"pause.png" 
                                         selectedImage:@"pause.png" 
                                                 block:^(id sender) {
                                                     if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                     [self pauseCallback];
                                                 }]; 
        itmPause.position=ccp(240,260);
        itmPause.scale=0.6;

        
        
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
        
        sprPauseBackground=[CCSprite spriteWithFile:@"pause-bg.png"];
        sprPauseBackground.position=ccp(240,196);
        [self addChild:sprPauseBackground];
        sprPauseBackground.visible=false;
        
        // Resume button ===============
        itmResume=[CCMenuItemImage itemWithNormalImage:@"resume.png" 
                                         selectedImage:@"resume.png" 
                                                 block:^(id sender) {
                                                     if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                     [self resumeCallback];
                                                 }]; 
        itmResume.position=ccp(240,72);
        
        //Return Button ===============
        itmReturn = [CCMenuItemImage itemWithNormalImage:@"return-home.png" 
                                           selectedImage:@"return-home.png" 
                                                   block:^(id sender) {
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                       
                                                       UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Return to Main Menu" message:@"End the game and return to main menu?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                                                       [alert addButtonWithTitle:@"Cancel"];
                                                       [alert show];
                                                    
            
        }];
        itmReturn.position=ccp(93,190);
        
        // Best of
        lblBestOf=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Best of %d",ad.numberOfRounds] fontName:@"ComixHeavy" fontSize:13];
        lblBestOf.position=ccp(380,290);
        lblBestOf.visible=false;
        [self addChild:lblBestOf];
        
        // music label
        lblMusic=[CCLabelTTF labelWithString:@"Music" fontName:@"ComixHeavy" fontSize:20];
        lblMusic.visible=false;
        lblMusic.position=ccp(250,220);
        [self addChild:lblMusic];
        
        
        NSString * strMusicOnImage;
        
        if(ad.playingBGM) strMusicOnImage=@"on-selected.png";
        else strMusicOnImage=@"on.png";
        
        NSString * strMusicOffImage;
        if(ad.playingBGM) strMusicOffImage=@"off.png";
        else strMusicOffImage=@"off-selected.png";
        
        
        itmMusicOn = [CCMenuItemImage itemWithNormalImage:strMusicOnImage
                                            selectedImage:strMusicOnImage 
                                                    block:^(id sender) {
                                                        ad.playingBGM=true;
                                                        
                                                        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.4f];
                                                        
                                                        if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                        
                                                        [itmMusicOn setNormalImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                        
                                                        [itmMusicOn setSelectedImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                        
                                                        [itmMusicOff setNormalImage:[CCSprite spriteWithFile:@"off.png"]];
                                                        [itmMusicOff setSelectedImage:[CCSprite spriteWithFile:@"off.png"]];
                                                        
                                                    }];   
        itmMusicOn.position=ccp(340,220);
        
        itmMusicOff = [CCMenuItemImage itemWithNormalImage:strMusicOffImage 
                                             selectedImage:strMusicOffImage 
                                                     block:^(id sender) {
                                                         ad.playingBGM=false;
                                                         [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:0];
                                                         
                                                         if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                         
                                                         [itmMusicOn setNormalImage:[CCSprite spriteWithFile:@"on.png"]];
                                                         [itmMusicOn setSelectedImage:[CCSprite spriteWithFile:@"on.png"]];
                                                         
                                                         [itmMusicOff setNormalImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                         [itmMusicOff setSelectedImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                     }];  
        itmMusicOff.position=ccp(410,220);
        
        

        
        // sfx label
        lblSFX=[CCLabelTTF labelWithString:@"SFX" fontName:@"ComixHeavy" fontSize:20];
        lblSFX.visible=false;
        lblSFX.position=ccp(262,160);
        [self addChild:lblSFX];
        
        
        NSString * strSFXOnImage;
        
        if(ad.playingSFX) strSFXOnImage=@"on-selected.png";
        else strSFXOnImage=@"on.png";
        
        NSString * strSFXOffImage;
        if(ad.playingSFX) strSFXOffImage=@"off.png";
        else strSFXOffImage=@"off-selected.png";
        
        
        itmSFXOn = [CCMenuItemImage itemWithNormalImage:strSFXOnImage 
                                          selectedImage:strSFXOnImage 
                                                  block:^(id sender) {
                                                      ad.playingSFX=true;
                                                      [[SimpleAudioEngine sharedEngine]setEffectsVolume:1];
                                                      
                                                      if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                      [itmSFXOn setNormalImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                      
                                                      [itmSFXOn setSelectedImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                      
                                                      [itmSFXOff setNormalImage:[CCSprite spriteWithFile:@"off.png"]];
                                                      [itmSFXOff setSelectedImage:[CCSprite spriteWithFile:@"off.png"]];
                                                  }];    
        
         
        itmSFXOn.position=ccp(340,160);
        itmSFXOff = [CCMenuItemImage itemWithNormalImage:strSFXOffImage 
                                           selectedImage:strSFXOffImage 
                                                   block:^(id sender) {
                                                       
                                                       ad.playingSFX=false;
                                                       [[SimpleAudioEngine sharedEngine]setEffectsVolume:0];
                                                       
                                                       [itmSFXOn setNormalImage:[CCSprite spriteWithFile:@"on.png"]];
                                                       
                                                       [itmSFXOn setSelectedImage:[CCSprite spriteWithFile:@"on.png"]];
                                                       
                                                       [itmSFXOff setNormalImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                       [itmSFXOff setSelectedImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                       
                                                   }]; 
        itmSFXOff.position=ccp(410,160);
        
        // Stage #
        lblStage=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Stage %d",ad.currentMatch] fontName:@"ComixHeavy" fontSize:13];
        lblStage.position=ccp(100,290);
        lblStage.visible=false;
        [self addChild:lblStage];
        
        
        lblPaused=[CCLabelTTF labelWithString:@"Paused" fontName:@"ComixHeavy" fontSize:33];
        lblPaused.position=ccp(240,290);
        lblPaused.visible=false;
        [self addChild:lblPaused]; 
        
        
        
        menuOverlay=[CCMenu menuWithItems:itmReturn,itmResume,itmSFXOn,itmSFXOff,itmMusicOn,itmMusicOff,nil];
        [menuOverlay setPosition:ccp( 0, 0)];
        [self addChild:menuOverlay];
        menuOverlay.visible=false;
        
        // initial battle values ==========================
        entryTime=0;
        lastChanged=0;

        roundTime=5;
//roundTime=1;
        ad.opponentHand=ROCK;
        ad.userHand=ROCK;
        sceneState=READY;
        switch(ad.currentMatch){
            case 1:
                ai=BASIC;
                break;
            case 2:
                ai=NORMAL;
                break;
            case 3:
                ai=SMART;
                break;
            case 4:
                ai=FAST;
                break;
            default:
                ai=BASIC;
                break;
        }
        
        [lblTimer setString:[NSString stringWithFormat:@"%d",roundTime]];
        [lblSubTimer setString:@"00"];
        
        
        record=[[NSMutableString alloc] initWithString:@""];
        
        roundBadges=[[NSMutableArray alloc]init];
        [self resetMatch];
        
	}
	return self;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    if (buttonIndex == 0) {     // and they clicked OK.
        ad.restarted=true;
        
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
    }
   
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

    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[super dealloc];
}

@end