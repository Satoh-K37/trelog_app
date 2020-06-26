// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery.jscroll.min.js
//= require infinite-scroll.pkgd.min



// 5秒後にメッセージを消す
$(function(){
  setTimeout("$('.notice, .alert').fadeOut('slow')", 5000);
});

// 画像のプレビュー機能。とりあえず画像を選択すると表示されるようになった。
$(function(){
  $fileField = $('#file')

    $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
      $preview = $("#img_field");
    
    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: 100,
          highit: 100,
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});


// タスク一覧ページでタスク削除を非同期で行う
// これなんかできてねぇな…
document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      var td = a.parentNode;
      var tr = td.parentNode;
      tr.style.display = 'none';
    });
  });
});

// // タスク一覧からタスクのステータスを変更できるようにする
//１、タスクのステータスがクリックされる
//２、条件毎に違ったAjaxの処理をする
//if ステータスがfalseの時
//   タスクのステータスをtrueに更新する
// else 
//   タスクんのステータスをtrueからfalseに更新する
// 
// document.getElementById("status_check").onclick = function () {
//   i
// }

// // これでアラートでた！！１
// $(function () {
//   //  チェックボックスが変更されると発火する
//   $(document).on('change', '#status_checkbox', function () {
//     // チェックボックスに入っている値を確認。デフォルトではfalse
//     var status_check = $(this).prop('checked');

//     if (status_check)
//       // チェックボックスがfalseの場合はこの処理を実装する
//       window.alert('trueになるぞ');
//     else
//       // チェックボックスがtrueの場合はこの処理を実装する
//       window.alert('falseになるぞ');
//   });
// });

// メモ欄の入力された文字をカウントする
$(function(){
  $("#task_memo").on("keyup", function() {
    let countNum = String($(this).val().length);
    $("#text_count").text(countNum + "/300");
  });
});

// タブ切り替え
(function($){

  $(document).ready(function(){
    var tablist = $("#tab_head li");
    var tabbody = $("#tab_body li");
  
    tablist.click(function(){
      var idx = tablist.index($(this));
      tablist.removeClass("on").eq(idx).addClass("on");
      tabbody.removeClass("on").eq(idx).addClass("on");
    });
  
  });
  
  })(jQuery);


// Ajaxで渡す先とか値を条件分岐の前で設定し、status_checkの値ごとに違う値を渡すようにしてやればいける？
// チェックボックスにこだわってしまっていたけど、ラジオボタンや普通のボタンでもいいんでは？
// １、ボタンをお押すとイベントが発火
// ２、タスクのステータスの真偽値を変更し、保存
// （ステータスの情報をどうやって持ってくるか…Hiddenでチェックボックスを置いて置いてボタンをクリックするとON/OFFされるようにする？）
// ３、タスクのステータスが変更され、「タスク「〇〇」が完了しました」というメッセージをTODOページでだし、完了したタスクはDoneページにいく。
// 行けそうな気がするけど多分どっかの詰めが甘いきがするんだよなぁ…

// $('#status_checkbox').click(function (e) {
//   var status_check = $(this).prop('checked');

//   if (status_check == false)
//     // 想定だとfalseがtureの切り替わるはず
//     alert("チェックボックスがonに変更されました。");
//   else
//     // tureがfalseに切り替わるはず
//     alert("チェックボックスがofに変更されました。");
// });


// function changeStatus() {
  
// }

// $('button[type=submit]').click(function () {
//   var error = false;
//   if ($('#value').length > 0) {
      
//       $.ajax({
//           url: '/CheckValue',
//           type: 'POST',
//           async: false,
//           traditional: true,
//           data: { value: $('#value').val() },
//           success: function (data) {
//               if (!data.IsSuccess) {
//                   error = true;
//               }
//           }
//       });

//       if (error ) {
//           return false;
//       }
//   }
// }

// $(document).ready()が動かないので、読み込んでいる
$(document).on("turbolinks:load", function () {
  // DOM要素の存在確認
  if ($("nav.pagination a[rel=next]").length) {
    // Infinite Scroll
    $(".task-list").infiniteScroll({
      // 次ページへのページネーションリンクを指定
      path: "nav.pagination a[rel=next]",
      // コンテナに追加する要素の指定 
      // ※コンテテナの指定とappendする要素の指定が上手くいかないとレイアウトが崩れるなどの問題が起こる
      append: ".task-list",
      // 無限スクロールを適用する範囲の指定。
      // trueだとコンテナを無限スクロール範囲とする。デフォルトでは`window`全体が適用範囲となる。
      elementScroll: true,
      // 読み込むたびにURLを書き換えるかどうかの指定
      history: true,
      // 一番下までスクロールする前に読み込むかどうかの指定
      prefill: false,
      // 読み込み中や読み込み終了時に表示するものを指定
      status: ".page-load-status",
      // ページネーションリンクを表示するかどうかを指定(display: noneと同じ)
      hideNav: ".pagination"
    })
  }
})