
#import "BSMessage.h"

@implementation BSMessage

+ (BSMessage *)messageFromUser:(NSString *)user withBody:(NSString *)body {
    BSMessage *messageToReturn = [[BSMessage alloc] initWithUser:user withBody:body];
    return messageToReturn;
}

- (id)initWithUser:(NSString *)user withBody:(NSString *)body {
    return [self initWithAttributes:@{@"user" : user, @"text" : body}];
}

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self)
        return nil;
    
    _sender = [attributes valueForKeyPath:@"user"];
    _body = [attributes valueForKeyPath:@"text"];
    
    return self;
}

- (NSDictionary *)serialized {
    return @{
        @"text" : _body,
        @"user" : _sender
    };
}

#pragma mark - 

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %@ from %@", NSStringFromClass([self class]), [self body], [self sender]];
}



@end
