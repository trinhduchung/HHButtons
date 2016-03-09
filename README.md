# HHButtons
Useful buttons to use including the loading button and a custom button, which making the hit area larger than the default.

# How to use
Just add the HHButtons folder to your project file.

# Usage
1. HHLoadingButton
  - In your action method add this implementation
  ```swift
  @IBAction func didLoadingButtonPress(sender: AnyObject) {
        loadingButton.showLoading()
        loadingButton.performSelector("hideLoading", withObject: nil, afterDelay: 2.0)
    }
  
  ```
  - There are 2 optionals to config: animationDuration to indicate the duration of animation and disableWhileLoading to set to indicate whether or not should disable the button while loading
  - See example project for more details.
2. HHHitAreaButton
  - Set hitTestEdgeInsets to increase the hit area of the button
  ```swift
  
  hitAreaButton.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20)
  ```
  
# Requirements
- iOS 8.0+
- Swift 2.0+
- ARC

# Author
Hung Trinh

# License
Free



