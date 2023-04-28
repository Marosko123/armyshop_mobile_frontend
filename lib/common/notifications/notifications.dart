import 'dart:math';

class Notification {
  String title;
  String body;

  Notification({required this.title, required this.body});
}

class Notifications {
  static List<Notification> weMissYouNotifications = [
    Notification(title: 'We miss you!', body: 'Come back to our app!'),
    Notification(
        title: 'Come back and see what\'s new!',
        body: 'Discover new features in our app today.'),
    Notification(
        title: 'We want you back!',
        body: 'Here is a discount code for your next purchase.'),
    Notification(
        title: 'We still miss you!',
        body: 'Don\'t forget about us! Come back to our app.'),
    Notification(
        title: 'Welcome back!', body: 'Thank you for returning to our app.'),
    Notification(
        title: 'Your account misses you!',
        body: 'Log in to see your latest activity.'),
    Notification(
        title: 'Haven\'t seen you in a while!',
        body: 'Discover exciting updates in our app now.'),
    Notification(
        title: 'Unlock new features!',
        body: 'Upgrade to our premium version now.'),
    Notification(
        title: 'Come back and shop some more!',
        body: 'Check out our latest products.'),
    Notification(
        title: 'We\'re sad without you!', body: 'Please come back to our app.'),
  ];

  static List<Notification> newProductNotifications = [
    Notification(
        title: 'New product!', body: 'Check out our new product in our app!'),
    Notification(
        title: 'Exciting new arrivals!',
        body: 'Explore our latest additions to the app.'),
    Notification(
        title: 'New season, new products!',
        body: 'Get ready for some fresh styles.'),
    Notification(
        title: 'The wait is over!',
        body: 'Our highly anticipated product is finally here.'),
    Notification(
        title: 'Be the first to know!',
        body:
            'Sign up for notifications to stay updated on our latest products.'),
    Notification(
        title: 'Our product lineup just got better!',
        body: 'Find out what\'s new and improved.'),
    Notification(
        title: 'Hot off the press!',
        body: 'Check out our latest products now available on our app.'),
    Notification(
        title: 'New product alert!',
        body: 'You don\'t want to miss out on our latest product.'),
    Notification(
        title: 'Discover new products!',
        body: 'Explore our latest arrivals on our app.'),
    Notification(
        title: 'Your favorite brand just released a new product!',
        body: 'Check it out now.'),
  ];

  static List<Notification> newDiscountNotifications = [
    Notification(
        title: 'New discount!', body: 'Check out our new discount in our app!'),
    Notification(
        title: 'Surprise sale!', body: 'Limited-time discount inside.'),
    Notification(
        title: 'It pays to shop with us!',
        body: 'Here is a special coupon code.'),
    Notification(
        title: 'Score big savings!',
        body: 'The perfect time to make a purchase.'),
    Notification(
        title: 'Don\'t miss this exclusive deal!',
        body: 'We have something special for you.'),
    Notification(title: 'Coupon madness!', body: 'Get your discount now.'),
    Notification(
        title: 'Unlock your discount!',
        body: 'A treat for you - use this code at checkout.'),
    Notification(title: 'Summer sale!', body: 'Shop now for discounts.'),
    Notification(
        title: 'Save now, thank yourself later!',
        body: 'Discover our current promotions.'),
    Notification(
        title: 'Hurry, this deal won\'t last forever!',
        body: 'Get your discount now.'),
  ];

  static List<Notification> newPromotionNotifications = [
    Notification(
        title: 'New promotion!',
        body: 'Check out our new promotion in our app!'),
    Notification(title: 'Become a VIP!', body: 'Unlock exclusive promotions.'),
    Notification(
        title: 'Spread the word and win!',
        body: 'Refer a friend for a chance to win.'),
    Notification(
        title: 'It pays to be social!',
        body: 'Follow us on social media for special promotions.'),
    Notification(
        title: 'Join our loyalty program!',
        body: 'Earn rewards for your purchases.'),
    Notification(
        title: 'Limited time offer!',
        body: 'Redeem this promotion while it lasts.'),
    Notification(
        title: 'It\'s a win-win!',
        body: 'Take advantage of our latest promotion today.'),
    Notification(
        title: 'Don\'t miss out on our latest event!',
        body: 'Join us and enjoy special promotions.'),
    Notification(
        title: 'The perfect time to shop!',
        body: 'Make the most of our current promotions.'),
    Notification(
        title: 'Extra perks for you!',
        body: 'Exclusive promotion just for our subscribers.'),
  ];

  static List<Notification> purchaseNotifications = [
    Notification(
        title: 'Thank you for your purchase!',
        body: 'We hope you will be satisfied with our products!'),
    Notification(
        title: 'Your order is being processed!',
        body: 'We will let you know when it ships.'),
    Notification(
        title: 'Enjoy your new purchase!',
        body: 'Thank you for shopping with us.'),
    Notification(
        title: 'Thank you for your business!',
        body: 'We appreciate your support.'),
    Notification(
        title: 'Your order is on its way!', body: 'Track your package now.'),
    Notification(
        title: 'Feedback welcome!',
        body: 'Let us know what you think of your recent purchase.'),
    Notification(
        title: 'You\'ve made a great choice!', body: 'Enjoy your new product.'),
    Notification(
        title: 'Your satisfaction is our top priority!',
        body: 'Let us know if you have any issues with your purchase.'),
    Notification(
        title: 'Thank you for choosing us!',
        body: 'Here are some recommendations based on your recent purchase.'),
    Notification(
        title: 'Your order has been shipped!',
        body: 'We hope it arrives soon and to your satisfaction.'),
  ];

  static List<Notification> welcomeNotifications = [
    Notification(
        title: 'Welcome to our app!',
        body: 'We hope you enjoy your experience with us.'),
    Notification(
        title: 'We appreciate your support!',
        body: 'Thank you for choosing our app as your go-to destination.'),
    Notification(
        title: 'Happy to have you with us!',
        body: 'We hope you find everything you need in our app.'),
    Notification(
        title: 'Thank you for joining our app!',
        body: 'We can\'t wait to show you everything we have in store.')
  ];

  static Notification getRandomNotification(List<Notification> notifications) {
    return notifications[Random().nextInt(notifications.length)];
  }
}
