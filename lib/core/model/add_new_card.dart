class CardInfo {
  String cardholderName;
  String cardno;
  String expmonth;
  String expyear;
  String cvv;

  CardInfo({
    this.cardholderName,
    this.cardno,
    this.expmonth,
    this.expyear,
    this.cvv,
  });

  @override
  String toString() {
    return 'CardInfo{card_no: $cardno,cardholdername: $cardholderName, exp_month: $expmonth, exp_year: $expyear, cvv:$cvv}';
  }
}