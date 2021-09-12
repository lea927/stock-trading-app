function calcPrice() {
  let toCurrency = Intl.NumberFormat('en-US');
  let stockPrice = parseFloat(document.getElementById('transaction_stock_price').value);
  let share = parseInt(document.getElementById('transaction_share').value);
  if (document.getElementById('transaction_share').value === '') {
    share = 0;
  }
  let purchase_price;
  purchase_price = stockPrice * share;

  document.getElementById('transaction_price').value = purchase_price;
}

document.getElementById('transaction_share').addEventListener('change', function (event) {
  const key = event.key;

  calcPrice();
});

document.getElementById('transaction_share').addEventListener('keyup', function (event) {
  const key = event.key;

  calcPrice();
});
