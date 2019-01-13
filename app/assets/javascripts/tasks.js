document.addEventListener('turbolinks:load', function () {
  document.querySelectorAll('.delete').forEach(function (a) {
    a.addEventListener('ajax:success', function () {
      a.parentNode.parentNode.style.display = 'none';
    });
  });
});