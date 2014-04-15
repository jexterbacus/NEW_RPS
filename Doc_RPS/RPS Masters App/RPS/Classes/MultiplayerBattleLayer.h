//
//  MultiplayerBattleLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "WinGameLayer.h"
#import "GameOverLayer.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Character.h"
#import "Dog.h"
#import "Robot.h"
#import "Boy.h"
#import "Snowman.h"
#import "Girl.h"
#import "AppDelegate.h"

@interface MultiplayerBattleLayer : CCLayer {
    CCLayer * baseLayer;
    CCLayer * winLayer;
    CCLayer * bubbleLayer;
    
    CCLabelTTF * lblTimer;              //timer label at top
    CCLabelTTF * lblColon;              //timer label at top
    CCLabelTTF * lblSubTimer;          //timer label at top
    CCLabelTTF * lblStatus;            //status label
    CCLabelTTF * lblGameOver;          //game over label
    
    CCLabelTTF * lblLeftName;                //name label
    CCLabelTTF * lblRightName;                //name label
    CCLabelTTF * lblWinText;
    CCLabelTTF * lblRematch;
    
    int winEffect;                      //reference to win sound effect
    
    CCSprite * sprOverlay;
    CCSprite *leftHand;                 //user's sprite
    CCSprite *rightHand;                //opponent's sprite
    
    
    // Win Lose Tie Overlays -------------
    CCSprite * sprWin;
    CCSprite * sprTie;
    CCSprite * sprLose;
    
    
    // In Game Buttons ----------------
    CCMenuItemImage * itmScissor;      //scissor button
    CCMenuItemImage * itmRock;         //rock button
    CCMenuItemImage * itmPaper;        //paper button
    CCMenuItemImage * itmPause;        //pause button
    
    
    // Rematch Overlay ----------------
    CCMenuItemImage * itmReturn;
    CCMenuItemImage * itmRematch;
    CCSprite * sprRematchBackground;
    
    
    // Win Overlay -------------------
    CCSprite * sprWinBackground;
    CCSprite * sprWinCharacter;
    CCSprite * sprTextBubble;
    
    // Start Overlay -----------------
    CCSprite * sprReady;
    CCSprite * sprGo;
    
    CCMenu * menu;                      //all interactive buttons
    CCMenu * menuOverlay;
    
    SceneState sceneState;              //current state of screen
    float timer;                        //count down timer for battle

    int ai;                             //AIType: to define AI logic
    int winCount;
    int loseCount;
    
    int roundTime;
    
    NSMutableArray * roundBadges;         //CCSprite of badges
    NSMutableString * record;
    
    bool transitioning;
    
    float syncTimer;
    
    
   
}

@property (nonatomic,assign) SceneState sceneState;
@property (nonatomic,assign) float timer;
@property(nonatomic,assign) bool transitioning;
+(CCScene *) scene;
-(void) nextRoundCallback;
-(void) showRematch;
-(void) updateLeftHand:(int)hand;
-(void) updateRightHand:(int)hand;
@end