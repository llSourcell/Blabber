
#import "BSClient.h"

@implementation BSClient {
    @private
    __strong CEPubnub *_pubnub;
    
    __strong BSClientInterfaceBlock _loginBlock;
}

+ (BSClient *)sharedClient {
    static BSClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BSClient alloc] init];
    });
    return _sharedClient;
}

- (id)init {
    self = [super init];
    if (!self)
        return nil;
    
    _pubnub = [[CEPubnub alloc] initWithPublishKey:@"pub-f84b22d9-ab10-4678-830f-190e94f0466a" subscribeKey:@"sub-008cca42-5218-11e1-a9f0-31bc26addfff" secretKey:@"sec-bc804583-b3eb-4927-9109-b118cdf802c1" cipherKey:nil useSSL:NO];
    [_pubnub setDelegate:self];
    
    return self;
}

#pragma mark - Subcription methods
- (void)subscribeToChannel:(NSString *)channelName withUsername:(NSString *)username successBlock:(void (^)(void))successBlock {
    _channelName = channelName;
    _username = username;
    
    _loginBlock = successBlock;
    [_pubnub subscribe:channelName];
}

- (void)unsubcribe {
    _channelName = nil;
    _username = nil;
    _loginBlock = nil;
    _messageReceivedBlock = nil;
    [_pubnub unsubscribeFromAllChannels];
}

- (void)fetchHistory {
    [_pubnub fetchHistory:@{@"channel" : _channelName, @"limit" : @(100)}];
}

#pragma mark - Sending functions
- (void)sendMessage:(BSMessage *)message {
    NSDictionary *messageDictionary = @{@"channel" : _channelName, @"message" : [message serialized]};
    [_pubnub publish:messageDictionary];
}

#pragma mark - Pubnub delegate methods
- (void)pubnub:(CEPubnub *)pubnub connectToChannel:(NSString *)channel {
    NSLog(@"Connected to channel");
    _loginBlock();
}

- (void)pubnub:(CEPubnub *)pubnub disconnectFromChannel:(NSString *)channel {
    NSLog(@"Disconnected from channel");
}

- (void)pubnub:(CEPubnub *)pubnub didFetchHistory:(NSArray *)messages forChannel:(NSString *)channel {
    NSLog(@"Fetched history!");
//    NSMutableArray *historyMessages = [NSMutableArray arrayWithCapacity:[messages count]];
    for (NSDictionary *messageDictionary in messages) {
        BSMessage *message = [[BSMessage alloc] initWithAttributes:messageDictionary];
        _messageReceivedBlock(message);
//        [historyMessages addObject:message];
    }
    
}

- (void)pubnub:(CEPubnub *)pubnub subscriptionDidReceiveDictionary:(NSDictionary *)message onChannel:(NSString *)channel {
    NSLog(@"Received dictionary \"%@\" on channel \"%@\"", message, channel);
    BSMessage *packedMessage = [[BSMessage alloc] initWithAttributes:message];
    _messageReceivedBlock(packedMessage);
}

- (void)pubnub:(CEPubnub *)pubnub subscriptionDidReceiveArray:(NSArray *)message onChannel:(NSString *)channel {
    NSLog(@"Received array \"%@\" on channel \"%@\"", message, channel);
}

- (void)pubnub:(CEPubnub *)pubnub subscriptionDidReceiveString:(NSString *)message onChannel:(NSString *)channel {
    NSLog(@"Received string \"%@\" on channel \"%@\"", message, channel);
}


@end
