#import <Foundation/Foundation.h>

@interface JKVClassInspector : NSObject

@property (strong, nonatomic, readonly) NSArray *allPropertiesBackedByInstanceVariables;
@property (strong, nonatomic, readonly) NSArray *weakProperties;
@property (strong, nonatomic, readonly) NSArray *nonWeakProperties;

+ (instancetype)inspectorForClass:(Class)aClass;
- (id)initWithClass:(Class)aClass;

- (BOOL)isObject:(id)object1 equalToObject:(id)object2 withPropertyNames:(NSArray *)propertyNames;
- (NSUInteger)hashObject:(id)object byPropertyNames:(NSArray *)propertyNames;

- (id)copyToObject:(id)targetObject
        fromObject:(id)object
            inZone:(NSZone *)zone
     propertyNames:(NSArray *)identityPropertyNames
 weakPropertyNames:(NSArray *)assignPropertyNames;


@end
