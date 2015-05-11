// Generated by Apple Swift version 1.2 (swiftlang-602.0.49.6 clang-602.0.49)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
#if __has_feature(nullability)
#  define SWIFT_NULLABILITY(X) X
#else
# if !defined(__nonnull)
#  define __nonnull
# endif
# if !defined(__nullable)
#  define __nullable
# endif
# if !defined(__null_unspecified)
#  define __null_unspecified
# endif
#  define SWIFT_NULLABILITY(X)
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Dispatch;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

SWIFT_CLASS("_TtC9FutureKit5FTask")
@interface FTask : NSObject
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class FTaskCompletion;
enum FTaskExecutor : NSInteger;

@interface FTask (SWIFT_EXTENSION(FutureKit))
- (FTask * __nonnull)onCompleteQ:(dispatch_queue_t __nonnull)q block:(id __nullable (^ __nonnull)(FTaskCompletion * __nonnull))b;
- (FTask * __nonnull)onComplete:(enum FTaskExecutor)executor block:(id __nullable (^ __nonnull)(FTaskCompletion * __nonnull))b;
- (FTask * __nonnull)onComplete:(id __nullable (^ __nonnull)(FTaskCompletion * __nonnull))block;
- (FTask * __nonnull)onSuccessResultWithQ:(dispatch_queue_t __nonnull)q :(id __nullable (^ __nonnull)(id __nullable))block;
- (FTask * __nonnull)onSuccessResultWith:(enum FTaskExecutor)executor :(id __nullable (^ __nonnull)(id __nullable))block;
- (FTask * __nonnull)onSuccessWithQ:(dispatch_queue_t __nonnull)q block:(id __nullable (^ __nonnull)(void))block;
- (FTask * __nonnull)onSuccess:(enum FTaskExecutor)executor block:(id __nullable (^ __nonnull)(void))block;
- (FTask * __nonnull)onSuccessResult:(id __nullable (^ __nonnull)(id __nullable))block;
- (FTask * __nonnull)onSuccess:(id __nullable (^ __nonnull)(void))block;
@end

@class NSException;
@class NSError;

SWIFT_CLASS("_TtC9FutureKit15FTaskCompletion")
@interface FTaskCompletion : NSObject
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithException:(NSException * __nonnull)ex OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithSuccess:(id __nullable)success OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCancelled OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithFail:(NSError * __nonnull)fail OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithContinueWith:(FTask * __nonnull)f OBJC_DESIGNATED_INITIALIZER;
+ (FTaskCompletion * __nonnull)Success:(id __nullable)success;
+ (FTaskCompletion * __nonnull)Fail:(NSError * __nonnull)fail;
+ (FTaskCompletion * __nonnull)Cancelled;
@end

typedef SWIFT_ENUM(NSInteger, FTaskExecutor) {
  FTaskExecutorPrimary = 0,
  FTaskExecutorImmediate = 1,
  FTaskExecutorAsync = 2,
  FTaskExecutorStackCheckingImmediate = 3,
  FTaskExecutorMain = 4,
  FTaskExecutorMainAsync = 5,
  FTaskExecutorMainImmediate = 6,
  FTaskExecutorUserInteractive = 7,
  FTaskExecutorUserInitiated = 8,
  FTaskExecutorDefault = 9,
  FTaskExecutorUtility = 10,
  FTaskExecutorBackground = 11,
};


SWIFT_CLASS("_TtC9FutureKit12FTaskPromise")
@interface FTaskPromise : NSObject
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly) FTask * __nonnull ftask;
- (void)completeWithCompletion:(FTaskCompletion * __nonnull)c;
- (void)completeWithSuccess:(id __nullable)result;
- (void)completeWithFail:(NSError * __nonnull)e;
- (void)completeWithException:(NSException * __nonnull)e;
- (void)completeWithCancel;
- (void)continueWithFuture:(FTask * __nonnull)f;
- (BOOL)tryCompleteWithCompletion:(FTaskCompletion * __nonnull)c;
- (void)completeWithCompletion:(FTaskCompletion * __nonnull)c onCompletionError:(void (^ __nonnull)(void))errorBlock;
@end


@interface FTaskPromise (SWIFT_EXTENSION(FutureKit))
@property (nonatomic, readonly, copy, getter=description) NSString * __nonnull description;
@property (nonatomic, readonly, copy, getter=debugDescription) NSString * __nonnull debugDescription;
- (id __nullable)debugQuickLookObject;
@end

@class NSCoder;

SWIFT_CLASS("_TtC9FutureKit13FutureNSError")
@interface FutureNSError : NSError
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithGenericError:(NSString * __nonnull)genericError OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithException:(NSException * __nonnull)exception OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly, copy, getter=localizedDescription) NSString * __nonnull localizedDescription;
@property (nonatomic, readonly, copy) NSString * __nullable genericError;
@end


@interface NSData (SWIFT_EXTENSION(FutureKit))
@end


@interface NSFileManager (SWIFT_EXTENSION(FutureKit))
@end


@interface NSObject (SWIFT_EXTENSION(FutureKit))
@property (nonatomic, readonly) id __nonnull lockObject;
@end



/// EXAMPLE FOLLOWS :
SWIFT_CLASS("_TtC9FutureKit14__ExampleClass")
@interface __ExampleClass : NSObject
@property (nonatomic) NSInteger regularVar;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface __ExampleClass (SWIFT_EXTENSION(FutureKit))
@property (nonatomic) NSInteger intWithDefaultValue;
@property (nonatomic) NSObject * __nullable weakDelegatePtr;
@property (nonatomic) id __nullable anyObjectOptional;
@property (nonatomic, copy) NSDictionary * __nonnull dictionaryWithDefaultValues;
@end

#pragma clang diagnostic pop