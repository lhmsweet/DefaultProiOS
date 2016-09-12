//
//  NSArray+BCAddons.h
//  FengChao
//
//  Created by Wang Daolong on 8/2/13.
//  Copyright (c) 2013 Baidu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 数组常用扩展方法
 */
@interface NSArray (BCAddons)

/*!
 返回第一个元素
 @return 数据长度大于1时返回第一个元素，否则返回nil
 */
- (id)firstObject;

/*!
 随机返回一个元素
 @return 返回的随机元素
 */
- (id)randomObject;

/*!
 安全的获取指定index的对象
 
 @param index 对象index
 
 @return 指定index的对象，如果越界，则返回nil
 
 @note 此方法会掩盖越界操作，需要调用者自行进行数据有效性检查
 */
- (id)objectOrNilAtIndex:(NSUInteger)index;

- (NSArray *)reverseObjects;

/*!
 *  返回数组个数
 *
 *  @return 返回个数，整形表示
 */
- (NSInteger)integerCount;

@end

@interface NSMutableArray (BCAddons)

/*!
 Replaces the object at the index with the new object, possibly adding the object.
 If the index is equal or larger than count,  placeholders and the element as NSNull are added to the end of the array, growing the array.
 
 @param obj The object with which to replace the object at idx index in the array.

 @param idx The index of the object to be replaced.
 @note  Nothing will happen if obj is nil.
        If idx is beyond the end of the array, One or more NSNull will be added as placeholders to make the index of obj is idx.
 */
- (void)setObjectOrNil:(id)obj atIndex:(NSUInteger)idx;

/*!
 Add object with checking nil inside without throw an exception
 
 @param obj object to be added
 */
- (void)addObjectOrNil:(id)obj;

/*!
 Remove object with boundary checking
 */
- (void)removeObjectOrNilAtIndex:(NSUInteger)index;

@end
