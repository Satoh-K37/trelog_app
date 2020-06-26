
// document.addEventListener('turbolinks:load', function() {
//   document.querySelectorAll('.delete').forEach(function(a) {
//     a.addEventListener('ajax:success', function() {
//       var td = a.parentNode;
//       var tr = td.parentNode;
//       tr.style.display = 'none';
//     });
//   });
// });



$.ajax({
  type: 'POST',
  url: url,
  data: data,
  success: success,
  dataType: dataType
})


// $(window).on('scroll', function() {
//   // scrollHeight = $(document).height();
//   // scrollPosition = $(window).height() + $(window).scrollTop();
//   var doch = $(document).innerHeight(); //ページ全体の高さ
//   var winh = $(window).innerHeight(); //ウィンドウの高さ
//   var bottom = doch - winh; //ページ全体の高さ - ウィンドウの高さ = ページの最下部位置
//   if (bottom <= $(window).scrollTop())  {
//         // $('.jscroll').jscroll({
//         //   contentSelector: '.task-list',
//         //   nextSelector: 'span.next:last a'
//         // });
//         console.log("最底辺！");
//   }
// });

$(window).on('scroll', function () {
  var doch = $(document).innerHeight(); //ページ全体の高さ
  var winh = $(window).innerHeight(); //ウィンドウの高さ
  var bottom = doch - winh; //ページ全体の高さ - ウィンドウの高さ = ページの最下部位置
  if (bottom <= $(window).scrollTop()) {
  //一番下までスクロールした時に実行
  console.log("最底辺！");
  }
  });