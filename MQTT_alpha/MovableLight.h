//
//  MovableLight.h
//  MQTT_alpha
//
//  Created by 北島知司 on 2015/03/12.
//  Copyright (c) 2015年 北島知司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MQTTKit.h"

@interface MovableLight : UIView {
    
    MQTTClient *client;
    
}

+ (instancetype) lightView;

@end
