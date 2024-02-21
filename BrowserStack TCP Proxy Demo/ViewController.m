#import "ViewController.h"
#import <CFNetwork/CFNetwork.h>
#import "PGConnectivityController_iOS.h"


@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *logLabel;
@property (nonatomic, strong) NSMutableString *logText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.logText = [NSMutableString string];
    
    [self setupButton];
    [self setupScrollView];
    [self setupLogLabel];
}

- (void)setupButton {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"Start" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.button];
    
    // Add constraints to position the button in the center of the view
    [NSLayoutConstraint activateConstraints:@[
        [self.button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.button.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20]
    ]];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.scrollView];
    
    // Add constraints to make the scrollView fill the view
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.button.bottomAnchor constant:20],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)setupLogLabel {
    self.logLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.logLabel.numberOfLines = 0;
    self.logLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.scrollView addSubview:self.logLabel];
    
    // Add constraints to position the logLabel inside the scrollView
    [NSLayoutConstraint activateConstraints:@[
        [self.logLabel.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor],
        [self.logLabel.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.logLabel.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20],
        [self.logLabel.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-20],
        [self.logLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-40] // Optional: Adjust the width to your preference
    ]];
}

- (void)buttonTapped {
    [self log:@"Fetching Pacfile\n"];
    
    // No need to change this
    NSString *url = @"https://www.example.com";
    
    // [self createSocketWithProxyHost:@"www.jabbbba.com" port:8081 proxyHost:@"jabbbba.com" proxyPort:8082];
    
    [self findProxyFromEnvironmentWithURL:url callback:^(NSString *proxyHost, NSInteger proxyPort) {
        [self log:@"BrowserStackLog : Callback triggerred \n"];
        
        if (proxyHost && proxyPort > 0) {
            [self log:@"BrowserStackLog : Proxy Host\n"];
            [self log:proxyHost];
            NSString *proxyPortString = [NSString stringWithFormat:@"%ld", (long)proxyPort];
            [self log:@"BrowserStackLog : Proxy Port\n"];
            [self log:proxyPortString];
            
            // UPDATE THIS to POKER URL
            NSString *host = @"www.example.org";
            UInt32 port = 80;
            
            [self createPokerServerSocketViaProxy:host port:port proxyHost:proxyHost proxyPort:proxyPort];
            
            [self log:@"\n---- FINISHED --- \n"];
            
        } else {
            [self log:@"BrowserStackLog : No Proxy Found or Proxy Disabled"];
        }
    }];
}

- (void)createPokerServerSocketViaProxy:(NSString *)pokerHost port:(UInt32)pokerPort proxyHost:(NSString *)proxyHost proxyPort:(UInt32)proxyPort {
    //    NSInputStream *inputStream = nil;
    //    NSOutputStream *outputStream = nil;
    //
    [self log:@"BrowserStackLog : Creating Socket"];
        [self log:@"BrowserStackLog : Opened Streams"];
        
        // Now, call the method to send the actual HTTP request
        BOOL privoxy_tunnel_established = [self configurePrivoxyToConnectToPokerServers:pokerHost port:pokerPort proxyHost:proxyHost proxyPort:proxyPort];
        
        if (privoxy_tunnel_established) {
            [self log:@"BrowserStackLog : Creating poker server socket"];
            [self createPokerServerSocket:proxyHost proxyPort:proxyPort];
        } else {
            [self log:@"BrowserStackLog : Cannot proceed, no tunnel established"];
        }
}


// Returns if connection was established or not
- (BOOL)configurePrivoxyToConnectToPokerServers:(NSString *)pokerHost port:(UInt32)pokerPort proxyHost:(NSString *)proxyHost proxyPort:(UInt32)proxyPort {
    NSInputStream *inputStream ;
    NSOutputStream *outputStream;
    
    // Create the socket streams
    // Streams are connected to proxy here
    [NSStream getStreamsToHostWithName:proxyHost port:proxyPort inputStream:&(inputStream) outputStream:&(outputStream)];
    
    if (inputStream && outputStream) {
        // Open the streams
        [inputStream open];
        [outputStream open];
        
        
        
        [self log:@"BrowserStackLog : Requesting / on the host\n"];
        
        // You can change the URL here...
        NSString *httpRequest = [NSString stringWithFormat:@"CONNECT %@:%u HTTP/1.1\n\n", pokerHost, pokerPort];
        [self log:@"BrowserStackLog : Configuring Privoxy: \n"];
        [self log:httpRequest];
        NSData *httpRequestData = [httpRequest dataUsingEncoding:NSUTF8StringEncoding];
        
        // Write the HTTP request to the output stream
        NSInteger bytesWritten = [outputStream write:[httpRequestData bytes] maxLength:[httpRequestData length]];
        
        if (bytesWritten == -1) {
            // Error handling
            [self log:@"BrowserStackLog : Failed to send HTTP request\n"];
            return false;
        } else {
            // Read the HTTP response
            NSMutableData *httpResponseData = [NSMutableData data];
            uint8_t buffer[1024];
            NSInteger bytesRead = 0;
            
            [inputStream open];
            
            do {
                bytesRead = [inputStream read:buffer maxLength:sizeof(buffer)];
                
                if (bytesRead > 0) {
                    [httpResponseData appendBytes:buffer length:bytesRead];
                }
            } while (bytesRead > 0);
            
            [inputStream close];
            
            // Convert HTTP response data to NSString for printing
            NSString *httpResponseString = [[NSString alloc] initWithData:httpResponseData encoding:NSUTF8StringEncoding];
            [self log:httpResponseString];
            if ([httpResponseString rangeOfString:@"200 Connection established"].location != NSNotFound) {
                [self log:@"BrowserStackLog : PrivoxyConfigured Successfully \n"];
                return true;
            } else {
                [self log:@"BrowserStackLog : PrivoxyConfigured Failed \n"];
                return false;
            }
        }
        
    }

    return false;
}


// HELPER METHODS


- (void)findProxyFromEnvironmentWithURL:(NSString *)url callback:(void (^)(NSString *host, NSInteger port))callback {
    NSDictionary *proxConfigDict = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    if (proxConfigDict) {
        if ([proxConfigDict[@"ProxyAutoConfigEnable"] integerValue] == 1) {
            NSString *pacUrl = proxConfigDict[@"ProxyAutoConfigURLString"];
            NSString *pacContent = proxConfigDict[@"ProxyAutoConfigJavaScript"];
            if (pacContent) {
                [self handlePacContentWithPacContent:pacContent url:url callback:callback];
            }
            [self downloadPacWithPacUrl:pacUrl callback:^(NSString *pacContent, NSError *error) {
                if (error) {
                    callback(nil, 0);
                } else {
                    [self handlePacContentWithPacContent:pacContent url:url callback:callback];
                }
            }];
        } else if ([proxConfigDict[@"HTTPEnable"] integerValue] == 1) {
            NSString *httpProxy = proxConfigDict[@"HTTPProxy"];
            NSInteger httpPort = [proxConfigDict[@"HTTPPort"] integerValue];
            callback(httpProxy, httpPort);
        } else if ([proxConfigDict[@"HTTPSEnable"] integerValue] == 1) {
            NSString *httpsProxy = proxConfigDict[@"HTTPSProxy"];
            NSInteger httpsPort = [proxConfigDict[@"HTTPSPort"] integerValue];
            callback(httpsProxy, httpsPort);
        } else {
            callback(nil, 0);
        }
        
        CFRelease((__bridge CFTypeRef)(proxConfigDict));
    }
}

- (void)handlePacContentWithPacContent:(NSString *)pacContent url:(NSString *)url callback:(void (^)(NSString *host, NSInteger port))callback {
    NSArray *proxies = (__bridge_transfer NSArray *)CFNetworkCopyProxiesForAutoConfigurationScript((__bridge CFStringRef)(pacContent), (__bridge CFURLRef)[NSURL URLWithString:url], NULL);
    if (proxies.count > 0) {
        NSDictionary *proxy = proxies[0];
        if ([proxy[(__bridge NSString *)kCFProxyTypeKey] isEqualToString:(__bridge NSString *)kCFProxyTypeHTTP] ||
            [proxy[(__bridge NSString *)kCFProxyTypeKey] isEqualToString:(__bridge NSString *)kCFProxyTypeHTTPS]) {
            NSString *host = proxy[(__bridge NSString *)kCFProxyHostNameKey];
            NSNumber *port = proxy[(__bridge NSString *)kCFProxyPortNumberKey];
            callback(host, [port integerValue]);
        } else {
            callback(nil, 0);
        }
    } else {
        callback(nil, 0);
    }
}

- (void)downloadPacWithPacUrl:(NSString *)pacUrl callback:(void (^)(NSString *pacContent, NSError *error))callback {
    __block NSMutableString *pacContent = [NSMutableString string];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.connectionProxyDictionary = @{};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue currentQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:pacUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            callback(nil, error);
        } else {
            pacContent = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            callback(pacContent, nil);
        }
    }];
    [task resume];
}

// Logging Helpers
- (void)log:(NSString *)text {
    [self displayText:text];
    [self logText:text];
}

- (void)displayText:(NSString *)text {
    [self.logText appendString:text];
    self.logLabel.text = self.logText;
}

- (void)logText:(NSString *)text {
    NSLog(@"Logged text: %@\n", text);
}

-(void)createPokerServerSocket:(NSString *)proxyHost proxyPort:(UInt32)proxyPort {
    
    PGConnectivityController_iOS* connectionBootstrapper = [PGConnectivityController_iOS sharedInstance];
    
    // inputStream and outputStream are opened earlier in createSocketwithProxyHost
    // no need to pass proxyHost and proxyHost, stream is already connected
    [connectionBootstrapper initiateConnection:@"real.partygaming.com.e7new.com" proxyHost:proxyHost proxyPort:proxyPort];
}

@end

