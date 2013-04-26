

#import <Foundation/Foundation.h>
//#import "BSUser.h"

@interface BSMessage : NSObject

@property (readonly) NSString *sender;
@property (readonly) NSString *body;

+ (BSMessage *)messageFromUser:(NSString *)user withBody:(NSString *)body;
- (id)initWithAttributes:(NSDictionary *)attributes;
- (NSDictionary *)serialized;

@end
