class AppConstants {
  //shared Preference
  static const String KEY_TOKEN_USER = 'user_token';
  static const String KEY_TOKEN_ADMIN = 'admin_token';
  static const String KEY_QUOTE_ID = 'quote_id';
  static const String KEY_CUSTOMER_ID = 'customer_id';
  static const String KEY_CURRENCY_CODE = "currency_code";

  static const String KEY_USER_EMAIL_ID = 'user_email_id';
  static const String KEY_USER_PASSWORD = 'user_password';
  static const String KEY_SHOULD_REMEMBER = 'user_should_remember';

  static const String KEY_CUSTOMER_NAME = 'customer_name';
  static const String KEY_CUSTOMER_MAILID = 'customer_mail_id';
  static const String KEY_MOBILE_NUMBER = 'customer_mobilenumber';

  static const String CAMERA = 'Capture Camera';
  static const String GALLERY = 'Pick from Gallery';
  //SnackBar ShowUp Time In seconds
  static const int TIME_SHOW_SNACK_BAR = 5;
  static const String IMAGE_PROFILE_PROTOCOL =
      'Image size should be 256x256'; // min 150x110
  //group ID
  static const int GROUP_ID_SHOP_OWNER = 1;
  static const int GROUP_ID_DISTRIBUTOR = 2;
  static const int GROUP_ID_SUB_ADMIN = 3;
  static const int STORE_ID = 1;
  static const int WEBSITE_ID = 1;

  //MARGIN
  static const double SIDE_MARGIN = 20.0;

  //product type
  static const String PRODUCT_TYPE_SIMPLE = 'simple';
  static const String PRODUCT_TYPE_CUSTOM = 'custom';
  static const String PRODUCT_TYPE_CONFIGURABLE = "configurable";

  //error
  static const String ERROR_INTERNET_CONNECTION = 'Network Connection Error !!';
  static const String ERROR = 'Something Went Wrong !!';
  static const String ALERT = 'ALERT';

  //Url helper
  static const String FIELD_CATEGORY_ID = 'category_id';
  static const String FIELD_NAME = 'name';
  static const String FIELD_SELLER_ID = 'seller_id';
  static const String FIELD_POPULAR_PRODUCT = 'POPULAR_PRODUCT';
  static const String FIELD_CREATED_AT = 'created_at';
  static const String CONDITION_TYPE_EQUAL = 'eq';
  static const String CONDITION_TYPE_LIKE = 'like';
  static const String CONDITION_TYPE_GREATER_THAN = 'gt';
  static const String CONDITION_TYPE_LESSER_THAN = 'lt';
  static const String CONDITION_TYPE_FROM = 'from';
  static const String CONDITION_TYPE_TO = 'to';
  static const String DIRECTION_ASCENDING = 'ASC';
  static const String DIRECTION_DESCENDING = 'DESC';
  static const int PRODUCT_VISIBILITY_SHOW = 4;
  static const int PRODUCT_VISIBILITY_HIDE = 1;

  static const String GALLERY_TYPE_IMAGE = 'image';

  //response status
  static const int RESPONSE_STATUS_SUCCESS = 1;
  static const int RESPONSE_STATUS_FAILED = 0;

  //drawer type
  static const int APP_DRAWER_TYPE_HEADER = 0;
  static const int APP_DRAWER_TYPE_DIVIDER = 1;
  static const int APP_DRAWER_TYPE_ITEM = 2;

  //cart item add options
  static const String CART_ADD_OPTION_1 = '1';
  static const String CART_ADD_OPTION_2 = '2';
  static const String CART_ADD_OPTION_3 = '3';
  static const String CART_ADD_OPTION_MORE = 'MORE';

  //drawer items
  static const String DRAWER_ITEM_HOME = "Home";
  static const String DRAWER_ITEM_DISTRIBUTORS = "Distributors";

  static const String DRAWER_ITEM_FASHION = "Fashion";
  static const String DRAWER_ITEM_HOME_APPLIANCES = "HomeAppliances";
  static const String DRAWER_ITEM_BEAUTY_AND_PERSONAL_CARE =
      "Beauty & Personal Care";
  static const String DRAWER_ITEM_GROCERY = "Grocery";

  static const String DRAWER_ITEM_MY_ORDER = "My Order";
  static const String DRAWER_ITEM_MY_CART = "My Cart";
  static const String DRAWER_ITEM_MY_WISH_LIST = "My Wishlist";
  static const String DRAWER_ITEM_MY_PROFILE = "My Profile";
  static const String DRAWER_ITEM_MANAGE_PAYMENT = "Manage Payment";
  static const String DRAWER_ITEM_PRODUCT_REVIEW = "Product Review";
  static const String DRAWER_ITEM_TRANSACTION = "Transaction";
  static const String DRAWER_ITEM_CONTACT_US = "Contact Us";
  static const String DRAWER_ITEM_TERMS_AND_CONDITION = "Terms & Condition";
  static const String DRAWER_ITEM_PRIVACY_POLICY = "Privacy Policy";
  static const String DRAWER_ITEM_LOGOUT = "Logout";
  static const List<String> DRAWER_STABLE_ITEMS_COLLECTIONS = [
    AppConstants.DRAWER_ITEM_HOME,
    AppConstants.DRAWER_ITEM_DISTRIBUTORS,
    AppConstants.DRAWER_ITEM_MY_ORDER,
    AppConstants.DRAWER_ITEM_MY_CART,
    AppConstants.DRAWER_ITEM_MY_WISH_LIST,
    AppConstants.DRAWER_ITEM_MY_PROFILE,
    AppConstants.DRAWER_ITEM_MANAGE_PAYMENT,
    AppConstants.DRAWER_ITEM_PRODUCT_REVIEW,
    AppConstants.DRAWER_ITEM_CONTACT_US,
    AppConstants.DRAWER_ITEM_TERMS_AND_CONDITION,
    AppConstants.DRAWER_ITEM_PRIVACY_POLICY,
    AppConstants.DRAWER_ITEM_LOGOUT
  ];

  // App Standard Property
  static const int PASSWORD_FIELD_MIN_LENGTH = 5;

//common text
  static const double FORM_CARD_CORNER = 20.0;
  static const String LOGIN = "Login";
  static const String SUBMIT = "Submit";
  static const String COMPARE = "Compare";
  static const String FILTER = "Filter";
  static const String ADDED = "Added";
  static const String NEXT = "Next";
  static const String EMAIL = "Email";
  static const String PASSWORD = "Password";
  static const String FORGOT_PASSWORD = "Forgot Password";
  static const String RESET_PASSWORD = 'Reset Password';
  static const String NEW_PASSWORD = 'New Password';
  static const String CURRENT_PASSWORD = 'Current Password';
  static const String CONFIRM_PASSWORD = 'Confirm New Password';
  static const String CANCEL_ORDER = "Cancel Order";
  static const String REVIEW_AND_PAYMENTs = 'Review & Payment';
  static const String PAY_NOW = 'Pay Now';
  static const String PLACE_ORDER = 'Place Order';
  static const String SHIPPING = 'Shipping';
  static const String SHIPPING_ADDRESS = 'Shipping Address';
  static const String E_MAIL_ADDRESS = 'Email Address';
  static const String FIRST_NAME = 'First name';
  static const String LAST_NAME = 'Last name';
  static const String COMPANY = 'Company';
  static const String STREET_ADDRESS = 'Street Address';
  static const String STREET_ADDRESS_ONE = 'Street Address 1';
  static const String STREET_ADDRESS_TWO = 'Street Address 2';
  static const String CITY = 'City';
  static const String STATE_PROVINCE = 'State / Province';
  static const String ZIP_POSTAL_CODE = 'Zip / Postal Code';
  static const String FAX = 'Fax';
  static const String COUNTRY = 'Country';
  static const String PHONE = 'Phone';
  static const String PHONE_NUMBER = 'Phone Number';
  static const String TRN = 'TRN #';
  static const String CHANGE_PASSWORD = 'Change Password';
  static const String EDIT_PROFILE = 'Edit Profile';
  static const String INVOICE = 'Invoice';
  static const String ORDER_SUMMARY = 'Order Summary';
  static const String PRODUCTS = 'Product';
  static const String QUANTITY = 'Quantity';
  static const String PRICE = 'Price';
  static const String REVIEW = 'Review';
  static const String CONTACT_DETAILS = 'Contact Details';
  static const String PRODUCT_DETAILS = 'Product Details';
  static const String DELIVERY_TYPE = 'Delivery Type';
  static const String FLAT_RATE = 'Flat Rate';
  static const String ADD = 'Add';
  static const String ADD_NEW_CARD = 'Add New Card';
  static const String CARD_PAYMENT = 'Payment';
  static const String ADD_TO_CART = 'Add to Cart';
  static const String ADD_NEW_ADDRESS = 'Add New Address';
  static const String ADD_ADDRESS = 'Add Address';
  static const String EDIT_ADDRESS = 'Edit Address';
  static const String OK = 'Ok';
  static const String YES = 'Yes';
  static const String NO = 'No';
  static const String ARE_YOU_SURE_CANCEL_ORDER =
      'Are you sure to cancel this order?';
  static const String PASSWORD_FIELD_INPUT_PROTOCOL =
      'Should contain minimum 8 characters which includes atleast 1 uppercase, 1 lowercase, 1 digit, 1 special character.';

//screen 'Edit Profile'
  static const int GENDER = 0;
  static const String UPDATE = "Update";
  static const String CANCEL = "Cancel";
  static const String OKAY = 'Okay';

//screen 'Payment Page'
  static const String FILL_DETAILS = 'Fill required details';
  static const String CARD_NUMBER = 'Card Number';
  static const String CARD_HOLDER_NAME = 'Card Holder Name';
  static const String CVV = 'CVV';
  static const String EXPIRY_MONTH = 'Expiry Month';
  static const String EXPIRY_YEAR = 'Expiry year';

//screen 'Order Confirmed'
  static const String SCREEN_ORDER_CONFIRMED = 'Order Confirmed';
  static const String TRACK_ORDER = 'Track Order';
  static const String CONTINUE_SHOPPING = 'Continue Shopping';
  static const String YOUR_ORDER_IS_CONFIRMED = 'Your Order is Confirmed!';
  static const String THANKS_SHOPPING_TEXT_1 =
      'Thanks for shopping! Your order ';
  static const String THANKS_SHOPPING_TEXT_2 = ' more items ';
  static const String THANKS_SHOPPING_TEXT_3 = 'has been successful.';

//screen 'ContactUs'
  static const String SEND = 'Send';

  //screen manage card
  // static const String ADD_NEW_CARD = 'Add New Card';

//screen Add New Card
  static const String MAKE_DEFAULT = 'Make Default';

//screen 'My Cart'
  /// Empty screen content
  static const String YOUR_SHOPPING_CART_IS_EMPTY =
      'Your shopping cart is empty.';
  static const String YOU_HAVE_ADD_ITEMS_SAVED_TO_BUY_LATER =
      'You have items saved to buy later.'
      ' \n To buy one or more now, click" Move to Cart"'
      ' \n next to the item.';
  static const String SHOP_NOW = 'Shop Now';

//screen 'My profile'
  static const String BASIC_INFORMATION = 'Basic Information';
  static const String NAME = 'Name';
  static const String EMAIL_ID = 'Email ID';
  static const String ADDRESS = 'Address';

// screen 'Filter'
  static const String APPLY = 'Apply';
  static const String RESET = 'Reset';
  static const String BRAND = 'Brand';
  static const String COLOR = 'Color';
  static const String SIZE = 'Size';

// screen 'Distributor UI Constants'
  static const String DISTRIBUTOR_PROFILE = 'Distributor Profile';
  static const String GENERAL_INFO = 'General Info';
  static const String ADDRESS_INFO = 'Address Info';
  static const String PREVIOUS = 'Previous';
  static const String WARE_HOUSE = 'Warehouse';
  static const String BANK_INFO = 'Bank Info';
  static const String COMPANY_INFO = 'Company Info';
  static const String SOCIAL_MEDIA_INFO = 'Social Media Info';
  static const String SEO_MANAGEMENT = 'SEO Management';

  // Top Distributor
  static const String DISTRIBUTOR_TOP_NAME = 'Distributor Name';

  //Myorder
  static const String EMAIL_CONTACT = 'Email_Contact';
  static const String PHONE_CONTACT = 'Phone_Contact';
  static const String MAP_CONTACT = 'Map_Contact';

  // Product Detail
  static const String CUSTOM_ATTRIBUTE_SPECIAL_PRICE = 'special_price';
  static const String CUSTOM_ATTRIBUTE_SPECIAL_FROM_DATE = 'special_from_date';
  static const String CUSTOM_ATTRIBUTE_SPECIAL_TO_DATE = 'special_to_date';
}
