/*global jQuery*/
/*global $*/

jQuery(document).on('click', '.opinion_tab', function() {
  $('.opinion_tab').css({'color':'#949faf'});
  $(this).css({'color':'black'});
  $('.comments_group').children().css('visibility','hidden');
  switch ($("div:eq(0)",this).text()) {
    // テキストで取得するのは変更に弱すぎるのでやめる
    case "良かった点":
      $('.opinion_select_bar').animate({'left':'0%'}, {duration: 300});
      $('.comments_group').css({'transform':'translate(0%,0px)'});
      $('.comments_section:eq(0)').css('visibility','visible');
      break;
    case "改善点":
      $('.opinion_select_bar').animate({'left':'33.3%'}, {duration: 300});
      $('.comments_group').css({'transform':'translate(-100%,0px)'});
      $('.comments_section:eq(1)').css('visibility','visible');
      break;
    case "質問・その他":
      $('.opinion_select_bar').animate({'left':'66.6%'}, {duration: 300});
      $('.comments_group').css({'transform':'translate(-200%,0px)'});
      $('.comments_section:eq(2)').css('visibility','visible');
      break;
  }
});

//全部comment-idで統一できるならする。div[comment-id]で検索してるので、問題ないかチェック。
//更新時の処理とかもcomment-idでセレクタ検索してる
jQuery(document).on('click', '.comment_edit_button', function() {
  var comment_id = $(this).data('edit-comment-id');
  $('div[data-comment-id=' + comment_id + '] .comment_edit_form').show();
  $('p[data-comment-id=' + comment_id + ']').hide();
});

jQuery(document).on('click', '.comment_edit_cancel', function() {
  var comment_id = $(this).data('edit-comment-cancel-id');
  $('div[data-comment-id=' + comment_id + '] .comment_edit_form').hide();
  $('p[data-comment-id=' + comment_id + ']').show();
  var comment_content = $('div[data-comment-id=' + comment_id + '] .comment_content p').html();
  comment_content = comment_content.replace(/<br>/g, "\n");
  $('div[data-comment-id=' + comment_id + '] .comment_edit_form textarea').val(comment_content);
});

jQuery(document).on('click', '.reply_button', function() {
  var comment_id = $(this).data('replied-id');
  $('div[data-comment-id=' + comment_id + '] .reply_form').show();
});

jQuery(document).on('click', '.reply_cancel', function() {
    var comment_id = $(this).data('reply-canceled-id');
    $('div[data-comment-id=' + comment_id + '] .reply_form').hide();
    $('div[data-comment-id=' + comment_id + '] .reply_form textarea').val("");
});

jQuery(document).on('turbolinks:load', function() { 
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
       $('.img_prev').attr('src', e.target.result);
     }
     reader.readAsDataURL(input.files[0]);
    }
  }
  $('.img_file').change(function() {
    readURL(this);
  }); 
});
