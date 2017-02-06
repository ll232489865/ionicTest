//
//  UIView+PX_SurveyCategory.m
//  GoddesCable
//
//  Created by 9yu on 15/6/19.
//  Copyright (c) 2015年 MI+. All rights reserved.
//

#import "UIView+PX_SurveyCategory.h"

@implementation UIView (PX_SurveyCategory)
+ (UILabel *)labelframe:(CGRect)rect labelTitle:(NSString *)title
                  color:(UIColor *)color
                   font:(NSInteger)font
          textAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    if (title) {
        label.text = title;
    }
    if (alignment) {
        label.textAlignment = alignment;
    }
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    label.backgroundColor = [UIColor clearColor];
    return label;
}
+(UIButton *)button:(CGRect)rect
           setTitle:(NSString *)title
       setbackImage:(UIImage *)backImage
               font:(NSInteger)font target:(id)target
             action:(SEL)action
       controlevent:(UIControlEvents)controlEvent
          textColor:(UIColor *)color
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (font) {
        btn.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    if (backImage) {
        [btn setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (target&&action) {
        [btn addTarget:target action:action forControlEvents:controlEvent];
    }
    
    return btn;
}
+ (UITextField *)textField:(CGRect)rect text:(NSString *)text
               placeholder:(NSString *)placeholder
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
               borderStyle:(UITextBorderStyle)style
                 alignment:(NSTextAlignment)alignment
                 backColor:(UIColor *)backColor
               clearButton:(UITextFieldViewMode)clearbtn
{
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    if (text.length > 0) {
        textField.text = text;
    }
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    if (textColor) {
        textField.textColor = textColor;
    }
    if (font) {
        textField.font = font;
    }
    if (style) {
        textField.borderStyle = style;
    }
    if (alignment) {
        textField.textAlignment = alignment;
    }
    if (backColor) {
        textField.backgroundColor = backColor;
    }
    if (clearbtn) {
        textField.clearButtonMode = clearbtn;
    }
    return textField;
}
@end

@implementation UIImage (extension)

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeIamge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeIamge;
}
@end

@implementation UIBarButtonItem (extension)

+ (UIBarButtonItem *)backButtonWithTarget:(id)target action:(SEL)selector
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setBackgroundImage:[UIImage imageNamed:@"Common_back"] forState:UIControlStateNormal];
    //[button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return backButton;
}
@end
