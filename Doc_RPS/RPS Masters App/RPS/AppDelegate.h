//
//  AppDelegate.h
//  RPS
//
//  Created by chibitotoro on 12-03-05.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import "StageManager.h"
#import "Character.h"
#import "GameCenterManager.h"
#import "iAd/ADBannerView.h"
#import "CCUIViewWrapper.h"
#import "RootViewController.h"

typedef enum{
    THREE_ROUNDS,
    FIVE_ROUNDS,
    SEVEN_ROUNDS,
    NUM_ROUNDS
    
}NumRounds;

typedef enum{
    LEFT_SIDE,
    RIGHT_SIDE
}Side;

typedef enum{
    BOY,
    GIRL,
    ROBOT,
    SNOWMAN,
    DOG,
    NUM_CHARACTERS
}CharacterType;

typedef enum {
    READY,
    GO,
    IN_BATTLE,
    THROWING,
    THROWN,
    VERSUS,
    RESULT,
    PAYOUT,
    PAUSED,
    WIN,
    LOSE,
    TIE,
    WAITING,
    GAME_OVER,
    NUM_STATES
} SceneState;

typedef enum{
    ROCK,
    PAPER,
    SCISSORS,
    NUM_HANDS
}HandState;


typedef enum{
    BASIC,
    FAST,
    NORMAL,
    SMART,
    NUM_AI_TYPES
}AIType;

typedef enum{
    STATE_PACKET,
    HAND_PACKET,
    SYNC_PACKET,
    NUM_PACKET_TYPES
}PacketType;

typedef struct {
    int type;
    int state;
    int character;
    int data;
    float time;
    int sequence;
}DataPacket;

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
    int numberOfRounds;
    HandState userHand;
    HandState opponentHand;
    int currentRound;
    int currentMatch;
    int currentStage;
    CharacterType selectedCharacter;
    CharacterType leftCharacter;
    CharacterType rightCharacter;
    CharacterType opponentCharacter;
    Side userSide;
    
    NSString * opponentName;
    
    UIImage * userImage;
    UIImage * opponentImage;
    
    CCLayer * activeLayer;
    Character * chrLeft;
    Character * chrRight;
	CCDirectorIOS	*director_;							// weak ref
    StageManager * mgrStage;
    
    bool playingBGM;
    bool playingSFX;
    bool restarted;
    bool inGame;
    
    bool matchStarted;
    bool isHost;
    
    bool disconnected;
    
    bool loadedOpponent;
    bool receivedStart;
    
    GKMatch * match;
    
    RootViewController * rootViewController;
    
    int singlePlayerWins;
    int multiplayerWins;
    
    GameCenterManager * mgrGameCenter;
    
    NSMutableArray * opponentLineUp;
    NSMutableArray * stageLineUp;
    
    NSUserDefaults *defaults;
    
    bool userReady;
    bool opponentReady;
    
}


@property (nonatomic,assign) bool userReady;
@property (nonatomic,assign) bool opponentReady;
@property (nonatomic,assign) bool restarted;
@property (nonatomic,assign) bool playingBGM;
@property (nonatomic,assign) bool playingSFX;
@property (nonatomic,assign) bool isHost;
@property (nonatomic,assign) bool matchStarted;
@property (nonatomic,assign) bool loadedOpponent;
@property (nonatomic,assign) bool receivedStart;
@property (nonatomic,assign) bool disconnected;
@property (nonatomic,assign) bool inGame;
@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic,assign) int numberOfRounds;
@property (nonatomic,assign) HandState userHand;
@property (nonatomic,assign) HandState opponentHand;
@property (nonatomic,assign) int currentRound;
@property (nonatomic,assign) int currentMatch;
@property (nonatomic,assign) int currentStage;


@property (nonatomic,assign) int singlePlayerWins;
@property (nonatomic,assign) int multiplayerWins;
@property (nonatomic,assign) CharacterType leftCharacter;
@property (nonatomic,assign) CharacterType rightCharacter;
@property (nonatomic,assign) CharacterType selectedCharacter;
@property (nonatomic,assign) CharacterType opponentCharacter;
@property (nonatomic,assign) Side userSide;
@property (nonatomic,copy) StageManager * mgrStage;
@property (nonatomic,copy) GameCenterManager * mgrGameCenter;
@property (nonatomic,copy) NSString * opponentName;
@property (nonatomic,copy) UIImage * userImage;
@property (nonatomic,copy) UIImage * opponentImage;
@property (nonatomic,assign) Character * chrLeft;
@property (nonatomic,assign) Character * chrRight;

@property (nonatomic,retain) NSMutableArray * opponentLineUp;
@property (nonatomic,retain) NSMutableArray * stageLineUp;
@property (nonatomic,retain) CCUIViewWrapper *wrapper;
@property (nonatomic,retain) NSUserDefaults *defaults;
@property (nonatomic,retain) CCLayer * activeLayer;
@property (nonatomic,retain) GKMatch * match;

@property (nonatomic,retain) RootViewController * rootViewController;
@end
