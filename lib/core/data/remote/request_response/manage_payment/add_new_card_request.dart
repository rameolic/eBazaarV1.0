class AddNewCardRequest {
  NewCard newcard;

  AddNewCardRequest({this.newcard});

  AddNewCardRequest.fromJson(Map<String, dynamic> json) {
    newcard = json['data'] != null
        ? new NewCard.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newcard != null) {
      data['data'] = this.newcard.toJson();
    }
    return data;
  }
}

class PaymentCardsListRequest {
  PaymentCard paymentcard;

  PaymentCardsListRequest({this.paymentcard});

  PaymentCardsListRequest.fromJson(Map<String, dynamic> json) {
    paymentcard = json['data'] != null
        ? new PaymentCard.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentcard != null) {
      data['data'] = this.paymentcard.toJson();
    }
    return data;
  }
}

class RemoveCardRequest {
  RemoveCard removeCard;

  RemoveCardRequest({this.removeCard});

  RemoveCardRequest.fromJson(Map<String, dynamic> json) {
    removeCard = json['data'] != null
        ? new RemoveCard.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.removeCard != null) {
      data['data'] = this.removeCard.toJson();
    }
    return data;
  }
}

class NewCard {
  String card_id;
  String customer_id;
  String card_no;
  String exp_month;
  String exp_year;
  String cvv;


  NewCard(
      { this.card_id,
        this.customer_id,
        this.card_no,
        this.exp_month,
        this.exp_year,
        this.cvv,
        });

  NewCard.fromJson(Map<String, dynamic> json) {
    card_id = json['id'];
    customer_id = json['customer_id'];
    card_no = json['card_no'];
    exp_month = json['exp_month'];
    exp_year = json['exp_year'];
    cvv = json['cvv'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.card_id;
    data['customer_id'] = this.customer_id;
    data['card_no'] = this.card_no;
    data['exp_month'] = this.exp_month;
    data['exp_year'] = this.exp_year;
    data['cvv'] = this.cvv;

    return data;
  }
}

class PaymentCard {
  String customer_id;

  PaymentCard(
      {this.customer_id,});

  PaymentCard.fromJson(Map<String, dynamic> json) {
    customer_id = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customer_id;
    return data;
  }
}

class RemoveCard {
  String card_id;

  RemoveCard({this.card_id,});

  RemoveCard.fromJson(Map<String, dynamic> json) {
    card_id = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.card_id;
    return data;
  }
}