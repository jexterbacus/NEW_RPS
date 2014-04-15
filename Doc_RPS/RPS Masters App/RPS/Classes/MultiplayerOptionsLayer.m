//
//  MultiPlayerOptionsLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiplayerOptionsLayer.h"
#import "MainMenuLayer.h"

#import "MultiplayerVersusLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation MultiplayerOptionsLayer

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	MultiplayerOptionsLayer *layer = [MultiplayerOptionsLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) nextFrame:(ccTime)dt{
    
}
-(id)init{
    
	if( (self=[super init])) {
        NSLog(@"START1");
        
         // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
         
        self.isTouchEnabled = YES;
        
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        ad.activeLayer=self;
        
        ad.matchStarted=false;
        ad.loadedOpponent=false;
        ad.receivedStart=false;
        
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
        sprMultiplayerLabel=[CCSprite spriteWithFile:@"single-player-label.png"];
        sprMultiplayerLabel.position=ccp(118,298);
        [self addChild:sprMultiplayerLabel];
        
        //Best of Label
        sprSignedInAs=[CCSprite spriteWithFile:@"signed-in-as.png"];
        sprSignedInAs.position=ccp(105,100);
        [self addChild:sprSignedInAs];
        
        lblUsername=[CCLabelTTF labelWithString:ad.mgrGameCenter.localPlayer.alias fontName:@"ComixHeavy" fontSize:16];
        lblUsername.color=ccc3(0,0,0);
        lblUsername.position=ccp(330,100);
        [self addChild:lblUsername];
        
        
        [self createCharacterAvatars];        
        
        [self createRoundButtons];        
        menu = [CCMenu menuWithItems:itmBoy,itmGirl,itmSnowman,itmDog,itmRobot, nil];
        [menu setPosition:ccp( 0,0)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
        
        //===========================================================================
        
        [self createMenuButtons];
        
        menu = [CCMenu menuWithItems:itmSearch,itmReturn, nil];
        [menu setPosition:ccp( 0,0)];
        // Add the menu to the layer
        [self addChild:menu];
        
        
        //selected frame
        sprSelectedFrame=[CCSprite spriteWithFile:@"selected-frame.png"];
        sprSelectedFrame.position=ccp(240, 240);
        [self addChild:sprSelectedFrame];
        
        
        //DEFAULT STATE ==============================================================
        
        [self selectOpponent:0];
        characterType=-1;
        [self selectCharacter:BOY];
        
                NSLog(@"END1");
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
-(void)selectOpponent:(int)o{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    opponent=o;
    
    switch(opponent){
        case 0:
            [itmRandom setNormalImage:[CCSprite spriteWithFile:@"random-button-selected.png"]];
            [itmRandom setSelectedImage:[CCSprite spriteWithFile:@"random-button-selected.png"]];
            [itmFriend setNormalImage:[CCSprite spriteWithFile:@"friend-button.png"]];
            [itmFriend setSelectedImage:[CCSprite spriteWithFile:@"friend-button.png"]];
            break;
        case 1:
            [itmRandom setNormalImage:[CCSprite spriteWithFile:@"random-button.png"]];
            [itmRandom setSelectedImage:[CCSprite spriteWithFile:@"random-button.png"]];
            [itmFriend setNormalImage:[CCSprite spriteWithFile:@"friend-button-selected.png"]];
            [itmFriend setSelectedImage:[CCSprite spriteWithFile:@"friend-button-selected.png"]];            break;
       
        default:
            break;
    }
}
-(void) createRoundButtons{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    // friend
    itmFriend = [CCMenuItemImage itemWithNormalImage:@"friend-button.png" 
                                      selectedImage:@"friend-button.png" 
                                              block:^(id sender) {
                                                  if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                  [self selectOpponent:1];
                                              }];
    itmFriend.position=ccp(410,100);
    
    // random
    itmRandom = [CCMenuItemImage itemWithNormalImage:@"random-button.png" 
                                     selectedImage:@"random-button.png" 
                                             block:^(id sender) {
                                                 if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"];     
                                                 [self selectOpponent:0];
                                             }];
    itmRandom.position=ccp(280,100);
    
    
    
}
-(void) createMenuButtons{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    //Start Button
    itmSearch = [CCMenuItemImage itemWithNormalImage:@"search-button.png" 
                                      selectedImage:@"search-button.png" 
                                              block:^(id sender) {
                                                  if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                  [ad.mgrGameCenter hostMatch];
                                              }];
    itmSearch.position=ccp(407,58);
    
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
    
    NSLog(@"STARTING MATCH");
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    ad.numberOfRounds=1;
    ad.currentMatch=1;
    ad.currentRound=1;

    
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerVersusLayer scene]]];
}
-(void) dealloc{

    [chrSelected release];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
 
@end
