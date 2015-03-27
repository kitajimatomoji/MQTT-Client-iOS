//
//  ViewController.h
//  MQTT_alpha
//
//  Created by 北島知司 on 2015/03/10.
//  Copyright (c) 2015年 北島知司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQTTKit.h"

#define BROKER_HOST @"broker.mqtt.kitajima.yokohama"

@interface ViewController : UIViewController{
    NSString *uuid;
    MQTTClient *client;
    MQTTClient *publisher;
    NSString *topic;
    
//    BOOL switch1_on;
//    BOOL switch2_on;
    
    IBOutlet UIView *light1;
    IBOutlet UIView *light2;
    IBOutlet UIView *switches;
    
    IBOutlet UIButton *light2f;
    IBOutlet UIButton *light1f;
    IBOutlet UIButton *switchControll;
    
    IBOutlet UISwitch *switch2f;
    IBOutlet UISwitch *switch1f;
}

- (IBAction)touch_light2f:(id)sender;
- (IBAction)touch_light1f:(id)sender;
- (IBAction)touch_switch2f:(id)sender;
- (IBAction)touch_switch1f:(id)sender;
- (IBAction)touch_switchall:(id)sender;

@end

