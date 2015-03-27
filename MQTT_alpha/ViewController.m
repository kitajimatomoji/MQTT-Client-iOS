//
//  ViewController.m
//  MQTT_alpha
//
//  Created by 北島知司 on 2015/03/10.
//  Copyright (c) 2015年 北島知司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // create the client with a unique client ID
    
    uuid = [[NSUUID UUID] UUIDString];
    
    light1.alpha = 0.0f;
    light2.alpha = 0.0f;
    switches.alpha = 1.0f;
    light1.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    light2.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    
    client = nil;
    NSString *clientID = [NSString stringWithFormat:@"publisher-%@", uuid];
    publisher = [[MQTTClient alloc] initWithClientId:clientID];
    
    // connect to the MQTT server
    [publisher connectToHost:BROKER_HOST
        completionHandler:^(NSUInteger code) {
            if (code != ConnectionAccepted) {
                NSLog(@"publisher failed to connect.");
                publisher = nil;
            }else{
                [publisher setWill:@"switch died."
                           toTopic:@"/light/2f"
                           withQos:AtLeastOnce
                            retain:YES];
                [publisher setWill:@"switch died."
                           toTopic:@"/light/1f"
                           withQos:AtLeastOnce
                            retain:YES];
            }
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)touch_light2f:(id)sender {
    NSString *clientID = [NSString stringWithFormat:@"touch-light2f-%@", uuid];
    NSLog(@"%@", clientID);
    light1.alpha = 0.0f;
    light2.alpha = 1.0f;
    switches.alpha = 0.0f;
    
    if(client != nil){
        [client disconnectWithCompletionHandler:^(NSUInteger code) {
            NSLog(@"Light2 disconnected.");
        }];
    }
    
    client = [[MQTTClient alloc] initWithClientId:clientID];
    UIView *l2 = light2;
    
    // define the handler that will be called when MQTT messages are received by the client
    [client setMessageHandler:^(MQTTMessage *message) {
        NSString *text = [message payloadString];
        NSLog(@"< received message for 2f [%@]", text);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if([text isEqualToString:@"on"]){
                l2.backgroundColor = [UIColor colorWithRed:1.0f green:0.95f blue:0.6f alpha:1.0f];
            }else{
                l2.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
            }
        });
        
    }];
    
    // connect the MQTT client
    [client connectToHost:BROKER_HOST
        completionHandler:^(MQTTConnectionReturnCode code) {
            if (code == ConnectionAccepted) {
                // when the client is connected, subscribe to the topic to receive message.
                [client subscribe:@"/light/2f"
            withCompletionHandler:nil];
            }
        }];
}



- (IBAction)touch_light1f:(id)sender {
    NSString *clientID = [NSString stringWithFormat:@"touch-light1f-%@", uuid];
    NSLog(@"%@", clientID);
    light1.alpha = 1.0f;
    light2.alpha = 0.0f;
    switches.alpha = 0.0f;
    
    if(client != nil){
        [client disconnectWithCompletionHandler:^(NSUInteger code) {
            NSLog(@"Light1 disconnected.");
        }];
    }
    
    client = [[MQTTClient alloc] initWithClientId:clientID];
    UIView *l1 = light1;

    // define the handler that will be called when MQTT messages are received by the client
    [client setMessageHandler:^(MQTTMessage *message) {
        NSString *text = [message payloadString];
        NSLog(@"< received message for 1f [%@]", text);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if([text isEqualToString:@"on"]){
                l1.backgroundColor = [UIColor colorWithRed:1.0f green:0.95f blue:0.6f alpha:1.0f];
            }else{
                l1.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
            }
        });
        
    }];
    
    // connect the MQTT client
    [client connectToHost:BROKER_HOST
        completionHandler:^(MQTTConnectionReturnCode code) {
            if (code == ConnectionAccepted) {
                // when the client is connected, subscribe to the topic to receive message.
                [client subscribe:@"/light/1f"
            withCompletionHandler:nil];
            }
        }];
}



- (IBAction)touch_switch2f:(id)sender {
    NSLog(@"touch_switch2f");
    
    NSString *message = @"off";
    if(switch2f.on) message = @"on";

    [publisher publishString:message
                     toTopic:@"/light/2f"
                     withQos:AtLeastOnce
                      retain:YES
           completionHandler:^(int mid) {
               NSLog(@"> publish 2F [%@]", message);
           }];
}

- (IBAction)touch_switch1f:(id)sender {
    NSLog(@"touch_switch1f");
    
    NSString *message = @"off";
    if(switch1f.on) message = @"on";
    
    [publisher publishString:message
                     toTopic:@"/light/1f"
                     withQos:AtLeastOnce
                      retain:YES
           completionHandler:^(int mid) {
               NSLog(@"> publish 1F [%@]", message);
           }];
}

- (IBAction)touch_switchall:(id)sender {
    light1.alpha = 0.0f;
    light2.alpha = 0.0f;
    switches.alpha = 1.0f;
}

@end
