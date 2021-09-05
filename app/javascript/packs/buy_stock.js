document.getElementById('share').addEventListener('keyup', function (event) {
  const key = event.key;

  let toCurrency = Intl.NumberFormat('en-US');
  let price = parseFloat(document.getElementById('price').value);
  let share = parseInt(document.getElementById('share').value);
  if (document.getElementById('share').value === '') {
    share = 0;
  }
  let purchase_price;
  purchase_price = price * share;

  document.getElementById('purchase_price').value = toCurrency.format(purchase_price);
});
