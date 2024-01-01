//
//  ViewController.h
//  BrowserStack TCP Proxy Demo
//
//  Created by Pulkit on 24/07/23.
//

#import <UIKit/UIKit.h>


@class ViewController;


@interface ViewController : UIViewController<NSStreamDelegate> {
    
    NSInputStream *inputStream ;
    NSOutputStream *outputStream;
    
    NSInputStream    *mInputStream;
    NSOutputStream    *mOutputStream;
}
@end

