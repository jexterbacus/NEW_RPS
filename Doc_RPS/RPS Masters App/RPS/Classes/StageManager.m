//
//  StageManager.m
//  RPS
//
//  Created by chibitotoro on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StageManager.h"
#import "AppDelegate.h"

@implementation StageManager
@synthesize stgCurrent,stageIndex;
-(id)init{
    if((self=[super init])){
        stageIndex=JUNGLE;
        stgCurrent=nil;
    }
    
    return self;
}

-(void) addStage:(CCLayer*)layer{
    
    Restaurant * restaurant;
    Casino * casino;
    Jungle * jungle;

    switch(stageIndex){
        case RESTAURANT:
            stgCurrent=[[Restaurant alloc]init];   //initialize as restaurant
            restaurant = (Restaurant*)stgCurrent;
            
            [layer addChild:restaurant.sprBackground];
            [layer addChild:restaurant.fanSpriteSheet];
            [layer addChild:restaurant.chef.ssCharacter];
            [layer addChild:restaurant.pan.ssCharacter];
            [layer addChild:restaurant.waitress.ssCharacter];
            break;
        case CASINO:
            stgCurrent=[[Casino alloc]init];   //initialize as restaurant
            casino = (Casino*)stgCurrent;
            
            [layer addChild:casino.sprBackground];
            [layer addChild:casino.roof.ssCharacter];
            [layer addChild:casino.bunnyGirl.ssCharacter];
            [layer addChild:casino.catGirl.ssCharacter];
            [layer addChild:casino.businessMan.ssCharacter];
            [layer addChild:casino.tycoon.ssCharacter];
            [layer addChild:casino.sign.ssCharacter];
            [layer addChild:casino.lever.ssCharacter];
            [layer addChild:casino.machine];
            [layer addChild:casino.slotLeft.ssCharacter];
            [layer addChild:casino.slotRight.ssCharacter];
            [layer addChild:casino.grandma.ssCharacter];
            [layer addChild:casino.glow.ssCharacter];
            break;
        case JUNGLE:
            stgCurrent=[[Jungle alloc]init];   //initialize as restaurant
            jungle = (Jungle*)stgCurrent;
            
            [layer addChild:jungle.sprBackground];
            [layer addChild:jungle.jungleSpriteSheet];
            [layer addChild:jungle.gull1.ssCharacter];
            [layer addChild:jungle.gull2.ssCharacter];
            break;
        default:
            break;
    }
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    //retrieve avatars
    ad.chrRight.sprAvatar.scaleX=-1;
    ad.chrRight.sprAvatar.position=stgCurrent.sprRightDPContainer.position;
    ad.chrLeft.sprAvatar.position=stgCurrent.sprLeftDPContainer.position;
    
    //composite top layers
    [layer addChild:stgCurrent.sprLeftLifeContainer];
    [layer addChild:stgCurrent.sprRightLifeContainer];
    [layer addChild:stgCurrent.sprLeftLife];
    [layer addChild:stgCurrent.sprRightLife];
    [layer addChild:stgCurrent.sprKOBox];
    
    [layer addChild:stgCurrent.sprLeftDPContainer];
    [layer addChild:stgCurrent.sprRightDPContainer];
    
    [layer addChild:ad.chrLeft.sprAvatar];
    [layer addChild:ad.chrRight.sprAvatar];
    
    if(ad.matchStarted){
        switch (ad.userSide) {
            case LEFT_SIDE:
                ad.chrRight.sprUserAvatar=[CCSprite spriteWithCGImage:[ad.opponentImage CGImage] key:nil];
                ad.chrLeft.sprUserAvatar=[CCSprite spriteWithCGImage:[ad.userImage CGImage] key:nil];
                break;
            case RIGHT_SIDE:
                ad.chrRight.sprUserAvatar=[CCSprite spriteWithCGImage:[ad.userImage CGImage] key:nil];
                ad.chrLeft.sprUserAvatar=[CCSprite spriteWithCGImage:[ad.opponentImage CGImage] key:nil];
                break;
            default:
                break;
        }
        
        [ad.chrRight.sprUserAvatar retain];
        [ad.chrLeft.sprUserAvatar retain];
        
        if([[CCDirector sharedDirector] enableRetinaDisplay:YES]){
            ad.chrLeft.sprUserAvatar.scale=ad.chrRight.sprUserAvatar.scale=1.3f; 
        }
        else {
            ad.chrLeft.sprUserAvatar.scale=ad.chrRight.sprUserAvatar.scale=3.f/8.f;
        }
        
        if(ad.chrLeft.sprUserAvatar!=nil){
            NSLog(@"USING LEFT AVATAR");
            ad.chrLeft.sprUserAvatar.position=ad.mgrStage.stgCurrent.sprLeftDPContainer.position;
            [layer addChild:ad.chrLeft.sprUserAvatar];        
        }
        if(ad.chrRight.sprUserAvatar!=nil){
            NSLog(@"USING RIGHT AVATAR");
            ad.chrRight.sprUserAvatar.position=ad.mgrStage.stgCurrent.sprRightDPContainer.position;
            [layer addChild:ad.chrRight.sprUserAvatar];        
        }

    }

}


-(void) update:(float)dt{
    Restaurant * restaurant;
    switch(stageIndex){
        case RESTAURANT:
            restaurant = (Restaurant*)stgCurrent;
            
            
                        
            break;
        default:
            break;
    }
}

-(void) pause{
    [stgCurrent pause];
}

-(void) resume{
    [stgCurrent resume];    
}


@end
