

#import <Foundation/Foundation.h>
#import "BSMessage.h"
#import "CEPubnub.h"

typedef void(^BSClientInterfaceBlock)(void);
typedef void(^BSClientMessageReceivedBlock)(BSMessage *message);

@interface BSClient : NSObject <CEPubnubDelegate>

@property (strong, nonatomic) NSString *channelName;
@property (strong, nonatomic) NSString *username;

@property (strong, nonatomic) BSClientMessageReceivedBlock messageReceivedBlock;

+ (BSClient *)sharedClient;
- (void)subscribeToChannel:(NSString *)channelName withUsername:(NSString *)username successBlock:(void (^)(void))successBlock;

- (void)unsubcribe;
- (void)sendMessage:(BSMessage *)message;
- (void)fetchHistory;

@end
