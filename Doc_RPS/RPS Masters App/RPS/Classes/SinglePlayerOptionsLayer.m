//
//  SinglePlayerOptionsLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SinglePlayerOptionsLayer.h"
#import "MainMenuLayer.h"
#import "SinglePlayerBattleLayer.h"
#import "SinglePlayerVersusLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation SinglePlayerOptionsLayer
+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	SinglePlayerOptionsLayer *layer = [SinglePlayerOptionsLayer node];
	[scene addChild: layer];
	return scene;
}

-(id)init{

	if( (self=[super init])) {
        
        /*
         // schedule a repeating callback on every frame
         [self schedule:@selector(nextFrame:)];
         
         self.isTouchEnabled = YES;
         */
        //AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
        //CGSize size = [[CCDirector sharedDirector] winSize];
        [CCMenuItemFont setFontSize:20];
        
        
        //Set the background image
        sprBackground=[CCSprite spriteWithFile:@"battle-options-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];
        
        lblCharacterName=[CCLabelTTF labelWithString:@"Boy" fontName:@"ComixHeavy" fontSize:15];
        [lblCharacterName setColor:ccc3(0, 0, 0)];
        lblCharacterName.position=ccp(95,140);
        [self addChild:lblCharacterName];
        
        
        // Section Header
        sprSinglePlayerLabel=[CCSprite spriteWithFile:@"single-player-label.png"];
        sprSinglePlayerLabel.position=ccp(118,298);
        [self addChild:sprSinglePlayerLabel];
        
        //Best of Label
        sprBestOf=[CCSprite spriteWithFile:@"best-of-label.png"];
        sprBestOf.position=ccp(105,100);
        [self addChild:sprBestOf];
        
        
        [self createCharacterAvatars];        
        
        [self createRoundButtons];        
        menu = [CCMenu menuWithItems:itmBoy,itmGirl,itmSnowman,itmDog,itmRobot,itmThree,itmFive,itmSeven, nil];
        //[menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp( 0,0)];
        
        // Add the menu to the layer
        [self addChild:menu];

        
        //===========================================================================
        
        [self createMenuButtons];
        
        menu = [CCMenu menuWithItems:itmStart,itmReturn, nil];
        [menu setPosition:ccp( 0,0)];
        // Add the menu to the layer
        [self addChild:menu];
        
        
        //selected frame
        sprSelectedFrame=[CCSprite spriteWithFile:@"selected-frame.png"];
        sprSelectedFrame.position=ccp(240, 240);
        [self addChild:sprSelectedFrame];
        
        
        //DEFAULT STATE ==============================================================

        [self selectNumRounds:FIVE_ROUNDS];
        characterType=-1;
        [self selectCharacter:BOY];
        
	}
    
    return self;
}

-(void) selectCharacter:(CharacterType)character{

    if(characterType==character) return;
    

    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];

    if(chrSelected!=nil){
        [self removeChild:chrSelected.ssCharacter cleanup:YES];
        [chrSelected release];
    }
    
    characterType=character;
    
    int posX=100;
    int posY=210;
    switch(characterType){
        case BOY:
            sprSelectedFrame.position=itmBoy.position;

            chrSelected=[[Boy alloc]init];
            posX+=10;
            
            ad.selectedCharacter=BOY;
            break;
        case GIRL:
            sprSelectedFrame.position=itmGirl.position;
            chrSelected=[[Girl alloc]init];
            posX-=5;
            
            ad.selectedCharacter=GIRL;
            break;
        case ROBOT:
            sprSelectedFrame.position=itmRobot.position;
            chrSelected=[[Robot alloc]init];
            ad.selectedCharacter=ROBOT;
            break;
        case SNOWMAN:
            sprSelectedFrame.position=itmSnowman.position;
            chrSelected=[[Snowman alloc]init];
            ad.selectedCharacter=SNOWMAN;
            break;
        case DOG:
            sprSelectedFrame.position=itmDog.position;
            chrSelected=[[Dog alloc]init];
            ad.selectedCharacter=DOG;
            break;
        default:
            break;
    }
    [lblCharacterName setString:chrSelected.name];
    [chrSelected addCharacterToLayer:self atX:posX atY:posY isFlipped:NO];
    
}
-(void)selectNumRounds:(NumRounds)rounds{
    
    if(rounds==numRounds) return;
    
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];

    switch(numRounds){
        case THREE_ROUNDS:
            [itmThree setNormalImage:[CCSprite spriteWithFile:@"three-rounds.png"]];
            [itmThree setSelectedImage:[CCSprite spriteWithFile:@"three-rounds.png"]];
            break;
        case FIVE_ROUNDS:
            [itmFive setNormalImage:[CCSprite spriteWithFile:@"five-rounds.png"]];            
            [itmFive setSelectedImage:[CCSprite spriteWithFile:@"five-rounds.png"]];            
            break;
        case SEVEN_ROUNDS:
            [itmSeven setNormalImage:[CCSprite spriteWithFile:@"seven-rounds.png"]];
            [itmSeven setSelectedImage:[CCSprite spriteWithFile:@"seven-rounds.png"]];
            break;
        default:
            break;
    }
    numRounds=rounds;
    
    switch(numRounds){
        case THREE_ROUNDS:
            [itmThree setNormalImage:[CCSprite spriteWithFile:@"three-rounds-selected.png"]];
            [itmThree setSelectedImage:[CCSprite spriteWithFile:@"three-rounds-selected.png"]];
            ad.numberOfRounds=3;
            break;
        case FIVE_ROUNDS:
            [itmFive setNormalImage:[CCSprite spriteWithFile:@"five-rounds-selected.png"]];            
            [itmFive setSelectedImage:[CCSprite spriteWithFile:@"five-rounds-selected.png"]];            
            ad.numberOfRounds=5;
            break;
        case SEVEN_ROUNDS:
            [itmSeven setNormalImage:[CCSprite spriteWithFile:@"seven-rounds-selected.png"]];
            [itmSeven setSelectedImage:[CCSprite spriteWithFile:@"seven-rounds-selected.png"]];
            ad.numberOfRounds=7;
            break;
        default:
            break;
    }
}
-(void) createRoundButtons{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    // 3 Button
    itmThree = [CCMenuItemImage itemWithNormalImage:@"three-rounds.png" 
                                      selectedImage:@"three-rounds.png" 
                                              block:^(id sender) {
                                                  if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                  [self selectNumRounds:THREE_ROUNDS];
                                              }];
    
    
    itmThree.position=ccp(250,100);
    
    // 5 Button
    itmFive = [CCMenuItemImage itemWithNormalImage:@"five-rounds.png" 
                                     selectedImage:@"five-rounds.png" 
                                             block:^(id sender) {
                                                 if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                 [self selectNumRounds:FIVE_ROUNDS];
                                             }];
    
    itmFive.position=ccp(330,100);
    
    // 7 Button
    itmSeven = [CCMenuItemImage itemWithNormalImage:@"seven-rounds.png" 
                                      selectedImage:@"seven-rounds.png" 
                                              block:^(id sender) {
                                                  if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                  [self selectNumRounds:SEVEN_ROUNDS];
                                              }];        
    itmSeven.position=ccp(410,100);

}
-(void) createMenuButtons{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    //Start Button
    itmStart = [CCMenuItemImage itemWithNormalImage:@"start-match.png" 
                                      selectedImage:@"start-match.png" 
                                              block:^(id sender) {
                                                  if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                  [self startMatch];
                                              }];
    itmStart.position=ccp(407,58);
    
    // Return Home
    itmReturn = [CCMenuItemImage itemWithNormalImage:@"return-home.png" 
                                       selectedImage:@"return-home.png" 
                                               block:^(id sender) {
                                                   if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                   [[CCDirector sharedDirector] replaceScene:
                                                    [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
                                               }];    
    
    itmReturn.position=ccp(93,58);
}
-(void) createCharacterAvatars{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    // Boy Button
    itmBoy = [CCMenuItemImage itemWithNormalImage:@"boy-select-avatar.png" 
                                    selectedImage:@"boy-select-avatar.png" 
                                            block:^(id sender) {
                                                if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"SelectCharacter.mp3"];     
                                                [self selectCharacter:BOY];
                                                
                                            }];    
    itmBoy.position=ccp(240,240);
    
    // Girl Button
    itmGirl = [CCMenuItemImage itemWithNormalImage:@"girl-select-avatar.png" 
                                     selectedImage:@"girl-select-avatar.png" 
                                             block:^(id sender) {
                                                 if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"SelectCharacter.mp3"];     
                                                 [self selectCharacter:GIRL];
                                             }];
    itmGirl.position=ccp(330,240);
    
    // Robot Button
    itmRobot = [CCMenuItemImage itemWithNormalImage:@"robot-select-avatar.png" 
                                      selectedImage:@"robot-select-avatar.png" 
                                              block:^(id sender) {
                                                  if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"SelectCharacter.mp3"];     
                                                  [self selectCharacter:ROBOT];
                                              }];
    itmRobot.position=ccp(420,240);
    
    // Snowman Button
    itmSnowman = [CCMenuItemImage itemWithNormalImage:@"snowman-select-avatar.png" 
                                        selectedImage:@"snowman-select-avatar.png" 
                                                block:^(id sender) {
                                                    if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"SelectCharacter.mp3"];     
                                                    [self selectCharacter:SNOWMAN];
                                                }];
    itmSnowman.position=ccp(240,160);
    
    // Dog Button
    itmDog = [CCMenuItemImage itemWithNormalImage:@"dog-select-avatar.png" 
                                    selectedImage:@"dog-select-avatar.png" 
                                            block:^(id sender) {
                                                if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"SelectCharacter.mp3"];     
                                                [self selectCharacter:DOG];
                                            }];
    itmDog.position=ccp(330,160);

}

-(void) startMatch{
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    ad.currentMatch=1;
    ad.currentRound=1;
    ad.leftCharacter=ad.selectedCharacter;
    
    // DETERMINE STAGE line up =========================
    if(ad.stageLineUp!=nil) [ad.stageLineUp release];
    ad.stageLineUp=[[NSMutableArray alloc]init];
    
    NSMutableArray * filteredStageList=[[NSMutableArray alloc]init];
    
    //add all stages
    for(int i=0;i<NUM_STAGES;i++){
        [filteredStageList addObject:[NSNumber numberWithInt:i]];
    }
    
    int randomStageIndex;
    int randomStage;
    while([filteredStageList count]>0){
        
        //pull out 3 characters
        randomStageIndex=arc4random()%[filteredStageList count];
        
        randomStage=[((NSNumber*)[filteredStageList objectAtIndex:randomStageIndex])intValue];
//randomStage=CASINO;
        [ad.stageLineUp addObject:[NSNumber numberWithInt:randomStage]];
        [filteredStageList removeObjectAtIndex:randomStageIndex];
    }
    [filteredStageList release];
    
    //add last stage as first stage

    [ad.stageLineUp addObject:[NSNumber numberWithInt:[((NSNumber*)[ad.stageLineUp objectAtIndex:0])intValue]]];
    
    for(int i=0;i<[ad.stageLineUp count];i++){
        printf("STAGE:%d\n",[((NSNumber*)[ad.stageLineUp objectAtIndex:i])intValue]);
    }
    ad.currentStage=[((NSNumber*)[ad.stageLineUp objectAtIndex:0]) intValue];
    
    
    // DETERMINE OPPONENT line up =========================
    if(ad.opponentLineUp!=nil) [ad.opponentLineUp release];
    ad.opponentLineUp=[[NSMutableArray alloc]init];
    
    

    
    NSMutableArray * filteredOpponentList=[[NSMutableArray alloc]init];
    
    for(int i=0;i<NUM_CHARACTERS;i++){
        if(i==ad.leftCharacter||i==DOG) continue;        //don't use DOG or selected character
        [filteredOpponentList addObject:[NSNumber numberWithInt:i]];
    }
    
    
    int randomOpponentIndex;
    int randomOpponent;
    while([filteredOpponentList count]>0&&[ad.opponentLineUp count]<3){
        
        //pull out 3 characters
        randomOpponentIndex=arc4random()%[filteredOpponentList count];
        
        randomOpponent=[((NSNumber*)[filteredOpponentList objectAtIndex:randomOpponentIndex])intValue];

        [ad.opponentLineUp addObject:[NSNumber numberWithInt:randomOpponent]];
        [filteredOpponentList removeObjectAtIndex:randomOpponentIndex];
    }
    [filteredOpponentList release];
    

    //add dog as last level opponent
    [ad.opponentLineUp addObject:[NSNumber numberWithInt:DOG]];
    
    for(int i=0;i<[ad.opponentLineUp count];i++){
        printf("LIST:%d\n",[((NSNumber*)[ad.opponentLineUp objectAtIndex:i])intValue]);
    }
    
    ad.rightCharacter= [((NSNumber*)[ad.opponentLineUp objectAtIndex:0]) intValue];
    
    
    // TRANSITION SCENE ======================
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[SinglePlayerVersusLayer scene]]];

    
}

-(void) dealloc{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    [chrSelected release];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
    
}
@end
