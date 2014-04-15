//
//  StageManager.h
//  RPS
//
//  Created by chibitotoro on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stage.h"
#import "Restaurant.h"
#import "Casino.h"
#import "Jungle.h"
#import "cocos2d.h"

typedef enum{
    RESTAURANT,
    CASINO,
    JUNGLE,
    NUM_STAGES
}StageIndex;

@interface StageManager : NSObject{
    Stage * stgCurrent;
    StageIndex stageIndex;
}

@property (nonatomic,retain) Stage * stgCurrent;
@property (nonatomic,assign) StageIndex stageIndex;
-(void) addStage:(CCLayer*)layer;
-(void) pause;
-(void) resume;
@end
