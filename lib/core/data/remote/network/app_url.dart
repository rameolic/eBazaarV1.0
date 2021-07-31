class AppUrl {
  //static final baseHost = "http://182.72.201.148";
  //static final baseHttp = "https://";
  //static final baseHost = "182.72.201.148";
  //https://dev.ebazaar.ae/dev
  static final baseHost =
      "ebazaar.ae";
  //"demo1.staging.ebazaar.ae";
  static final baseHttp = "https://";
  static final baseUrl = "$baseHttp$baseHost";
  static final paymentBaseUrl = "https://demo-ipg.ctdev.comtrust.ae:2443";
  //static final paymentBaseUrl = "https://demo-ipg.ctdev.comtrust.ae";
  static final baseImageUrl = '$baseUrl/pub/media/catalog/product/';
  static final baseImageUrl1 = '$baseUrl/pub/media/catalog/product';
  static final distImageUrl = "$baseUrl/pub/media/Distributors/Sellerlogo/";
  static final distImageUrl1 = "$baseUrl/pub/media/Distributors/Sellerlogo";
  static final baseCategoryImageUrl = "$baseUrl/pub/media/catalog/category/";
  static final baseCategoryImageUrl1 = "$baseUrl/pub/media/catalog/category";
  //register
  static final pathRegister = "/rest/default/V1/customers"; //POST
  //login
  static final pathLogin = "/rest/default/V1/integration/customer/token"; //POST
  //AdminToken
  static final pathAdminToken =
      "/rest/default/V1/integration/admin/token"; //POST
  //forgotPwdApiLink
  static final pathForgotPwd = "/rest/default/V1/customers/password"; //PUT
  //getUserDetailByToken
  static final pathGetUserDetailByToken = "/rest/default/V1/customers/me"; //GET
  //getQuoteID
  static final pathGetCartQuoteId = "/rest/default/V1/carts/mine"; //POST
  //search
  static final pathSearch = "/rest/default/V1/search"; //GET
  //custom category list (with image id)
  static final pathCategoryCustomList =
      '/rest/V1/shopkeeper/CategoryCustomList'; //GET
  //load subCategory list
  static final pathSubCategoryList = '/rest/default/V1/categories/'; //GET
  // top distributor list
  static final pathTopDistributorList =
      '/rest/V1/shopkeeper/DistributorList'; //GET
  //getProducts
  static final pathProductsSearch = "/rest/V1/products"; //GET
  //Hit:1. getRatingListByStoreId
  static final pathRatingList = "/rest/V1/rating/ratings/"; //GET
  //Hit:2. getProductReviewByProductId
  static final pathProductReviewList = "/rest/V1/review/reviews/"; // GET
  //Hit:3. AddReviewToProductByLoggedCustomer
  static final pathAddReviewToProduct = "/rest/V1/review/mine/post"; //POST
  //Hit:4. getRelatedProduct
  static final pathRelatedProduct = "/rest/V1/RelatedProductList"; //POST
  //getCartList
  static final pathCartList =
      "/rest/V1/shopkeeper/CartCustomList?quoteId="; // Get
  //getCartAdd
  static final pathCartItemQtyUpdate = "/rest/V1/carts/"; //POST
  //getCountriesList
  static final pathCountriesList = "/rest/V1/directory/countries"; //GET
  //getRemoveCart
  static final pathRemoveCart = "/rest/V1/carts/"; //DELETE
  //addCoupon
  static final pathAddCoupon = "/rest/V1/carts/"; //PUT
  //removeCoupon
  static final pathRemoveCoupon = "/rest/V1/carts/"; //DELETE
  //formKey
  static final formKey = "/rest/V1/form-key";
  //webFormLogin
  static final webFormLogin = "/customer/ajax/login/";
  //estimate shipping methods
  static final shippingMethods =
      "/rest/default/V1/carts/mine/estimate-shipping-methods/"; //POST
  // set shipping methods
  static final setShippingMethods =
      "/rest/V1/carts/mine/shipping-information"; //POST
  // get cart total
  static final getCartTotal = "/rest/V1/carts/mine/totals"; //GET
  //Wish List Related Apis
  static final pathWishList = "/rest/V1/ipwishlist/items"; // GET
  // Remove wist list item Api
  static final pathRemoveWishListItem = "/rest/V1/ipwishlist/delete/"; // DELETE
  // Add wish list item to cart
  static final pathAddWishListItemToCart = "/rest/V1/carts/mine/items"; // POST

  // All distributor api
  static final pathAllDistributor =
      "/rest/V1/shopkeeper/DistributorAllList"; // GET
  // Popular products
  static final pathPopularProducts = "/rest/V1/best-seller-product";

  // add to cart custom
  static final pathAddToCartCustom = "/rest/V1/carts/mine/items";

  // add to wish list
  static final pathAddToWishList = "/rest/V1/ipwishlist/add/";

  // remove item from wish list
  static final pathRemoveItemFromWishList = "/rest/V1/ipwishlist/delete/";

  // share wish list
  static final pathShareWishList = "/shopowner/Apiproduct/Sharewishlist";

  // create order
  static final pathCreateOrder = "/rest/V1/carts/mine/order";

  // get order by id
  static final pathGetOrderById = "/rest/V1/orders/";

  // cart quote id
  static final pathCartQuoteId = "/rest/default/V1/carts/mine";

  //order list details
  static final getOrderList = "/rest/default/V1/orders";

  //get distribution wise order list
  static final getDistributionWiseOrderList = "/rest//V1/list-orders";

  //contactUs details
  static final putContactDetails = "/shopowner/Apicontact/Contactform"; //POST

  //contactUS AddressDetails
  static final getContactUsAddress = "/rest/V1/config/store-details"; //GET

  // change password
  static final pathChangePassword = "/rest/V1/customers/me/password";

  // update profile
  static final pathUpdateProfile = "/rest/V1/customers/me";

  //TermsandCondition
  static final pathTermsAndCondition = "/rest/V1/cmsBlock/";

  //AllListUrl
  static final allListUrl = "/rest//V1/shopkeeper/AllUrlList";

  //ProductReview
  static final getProductReview = "/rest/V1/review/mine/allreviews";

  //Manage Payment List
  static final managePaymentList = "/rest/V1/card/list";

  //Add New Card
  static final addNewCard= "/rest/V1/card/add";

  //Add delete Card
  static final deleteNewCard = "/rest/V1/card/delete";

  //FilterList
  static final pathFilterList = "/rest/V1/shopkeeper/FilterList"; //POST

  //RemoveAddress
  static final deleteAddress = "/rest/V1/remove/address?address_id="; //DELETE

  //update Address
  static final updateAddress = "/rest/V1/update/address"; //POST

  //Add Address
  static final addAddress = "/rest/V1/add/address"; //POST

  // Basic Info
  static final pathBasicInfo = "/rest/V1/store/storeConfigs"; //GET

  // Add Products to Compare
  static final pathAddProductsToCompare =
      "/rest/V1/add-product-to-compare"; //POST

  // Remove Products from compare
  static final pathRemoveProductsFromCompare =
      "/rest/V1/compare-product-remove?product_id="; //DELETE

  // Compare product list
  static final pathProductCompareList = "/rest/V1/compare-product-list"; //GET

  // getProfileImage
  static final getProfileImage = "/rest/V1/User/Avatar"; //GET

//postProfileImage
  static final postProfileImage =
      "/shopowner/apiCustomer/Customerprofile"; //POST

//postTotalInformation for Cart totals
  static final postTotalInformation =
      "/rest/default/V1/carts/mine/totals-information"; //POST

//postPaymentInformation for Payment
  static final postPaymentInformation =
      "/rest/default/V1/carts/mine/payment-information"; //POST

  // post card  Payment
  static final postCardPayment = ""; //POST
}
