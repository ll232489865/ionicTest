//
//  UIView+PX_SurveyCategory.h
//  GoddesCable
//
//  Created by 9yu on 15/6/19.
//  Copyright (c) 2015年 MI+. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (PX_SurveyCategory)
+ (UILabel *)labelframe:(CGRect)rect labelTitle:(NSString *)title
                  color:(UIColor *)color
                   font:(NSInteger)font
          textAlignment:(NSTextAlignment)alignment;

+(UIButton *)button:(CGRect)rect
           setTitle:(NSString *)title
       setbackImage:(UIImage *)backImage
               font:(NSInteger)font target:(id)target
             action:(SEL)action
       controlevent:(UIControlEvents)controlEvent
          textColor:(UIColor *)color;

+ (UITextField *)textField:(CGRect)rect text:(NSString *)text
               placeholder:(NSString *)placeholder
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
               borderStyle:(UITextBorderStyle)style
                 alignment:(NSTextAlignment)alignment
                 backColor:(UIColor *)backColor
               clearButton:(UITextFieldViewMode)clearbtn;

@end
@interface UIImage (extension)

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

@end

@interface UIBarButtonItem (extension)
+ (UIBarButtonItem *)backButtonWithTarget:(id)target action:(SEL)selector;
@end
