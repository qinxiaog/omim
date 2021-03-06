#import "Common.h"
#import "UIViewController+Navigation.h"

namespace
{
CGFloat constexpr kButtonExtraWidth = 16.0;
}  // namespace

@implementation UIViewController (Navigation)

- (UIBarButtonItem *)negativeSpacer
{
  UIBarButtonItem * spacer =
      [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                    target:nil
                                                    action:nil];
  spacer.width = -kButtonExtraWidth;
  return spacer;
}

- (UIBarButtonItem *)buttonWithImage:(UIImage *)image action:(SEL)action
{
  CGSize const buttonSize = {image.size.width + kButtonExtraWidth, image.size.height};
  UIButton * button = [[UIButton alloc] initWithFrame:{{}, buttonSize}];
  [button setImage:image forState:UIControlStateNormal];
  [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
  return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (NSArray<UIBarButtonItem *> *)alignedNavBarButtonItems:(NSArray<UIBarButtonItem *> *)items
{
  return [@[ [self negativeSpacer] ] arrayByAddingObjectsFromArray:items];
}

- (UIBarButtonItem *)backButton
{
  return [self buttonWithImage:[UIImage imageNamed:@"ic_nav_bar_back"] action:@selector(backTap)];
}

- (void)showBackButton
{
  self.navigationItem.leftBarButtonItems = [self alignedNavBarButtonItems:@[ [self backButton] ]];
}

- (void)backTap { [self.navigationController popViewControllerAnimated:YES]; }

- (UIStoryboard *)mainStoryboard { return [UIStoryboard storyboardWithName:@"Mapsme" bundle:nil]; }

@end
