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
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require_tree .

// ログインした時などに10秒後にメッセージを消す
$(function(){
  setTimeout("$('.notice, .alert').fadeOut('slow')", 10000);
});


// 画像のプレビュー機能。とりあえず画像を選択すると表示されるようになった。でかいのでリサイズする
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

// // // $(document).ready(function () {
// // //   var view_box = $('.view_box');
  
// // //   $(".file").on('change', function(){
// // //       var fileprop = $(this).prop('files')[0],
// // //           find_img = $(this).next('img'),
// // //           fileRdr = new FileReader();
    
// //       if(find_img.length){
// //         find_img.nextAll().remove();
// //         find_img.remove();
// //       }
    
// //     var img = '<img width="200" alt="" class="img_view"><br><a href="#" class="img_del">画像を削除する</a>';
// //     view_box.append(img);
    
// //     fileRdr.onload = function() {    
// //       view_box.find('img').attr('src', fileRdr.result);
// //       img_del(view_box); 
// //     }
// //     fileRdr.readAsDataURL(fileprop);  
// //   });
  
// //   function img_del(target)
// //   {
// //       target.find("a.img_del").on('click',function(){

// //       if(window.confirm('サーバーから画像を削除します。\nよろしいですか？'))
// //       {
// //           $(this).parent().find('input[type=file]').val('');
// //           $(this).parent().find('.img_view, br').remove();
// //           $(this).remove();
// //       }

// //       return false;
// //     });
// //   }  
// // });

// // // // // // // // // // // // // 

  // 選択された画像を取得し表示
  // $( document ).on('turbolinks:load', function() {
  //   function readURL(input) {
  //     if (input.files && input.files[0]) {
  //       var reader = new FileReader();
  
  //       reader.onload = function (e) {
  //         $('#icon_img_prev').attr('src', e.target.result);
  //       }
  //       reader.readAsDataURL(input.files[0]);
  //     }
  //   }
    
  //   $("#post_img").change(function(){
  //     $('#icon_img_prev').removeClass('hidden');
  //     $('.circle_icon').remove();
  //     readURL(this);
  //   });
  // });