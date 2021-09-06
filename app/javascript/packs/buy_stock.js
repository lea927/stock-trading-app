document.getElementById('transaction_share').addEventListener('keyup', function (event) {
  const key = event.key;

  let toCurrency = Intl.NumberFormat('en-US');
  let price = parseFloat(document.getElementById('transaction_price').value);
  let share = parseInt(document.getElementById('transaction_share').value);
  if (document.getElementById('transaction_share').value === '') {
    share = 0;
  }
  let purchase_price;
  purchase_price = price * share;

  document.getElementById('transaction_purchase_price').value = toCurrency.format(purchase_price);
});
