/*global jQuery*/
/*global $*/

jQuery(document).on('click', '.opinion_tab', function() {
  $opinionTab = $('.opinion_tab');
  $opinionSelectBar = $('.opinion_select_bar');
  $commentsGroup = $('.comments_group');
  $commentsSection = $('.comments_section');
  $positiveComments = $('#positive_comments');
  $negativeComments = $('#negative_comments');
  $questionComments = $('#question_comments');

  $opinionTab.css({'color':'#949faf'});
  $(this).css({'color':'black'});
  $commentsSection.css('visibility','hidden');

  switch ($(this).attr('id')) {
    case "positive_button":
      $opinionSelectBar.animate({'left':'0%'}, {duration: 300});
      $commentsGroup.css({'transform':'translate(0%,0px)'});
      $positiveComments.css('visibility','visible');
      break;
    case "negative_button":
      $opinionSelectBar.animate({'left':'33.3%'}, {duration: 300});
      $commentsGroup.css({'transform':'translate(-100%,0px)'});
      $negativeComments.css('visibility','visible');
      break;
    case "question_button":
      $opinionSelectBar.animate({'left':'66.6%'}, {duration: 300});
      $commentsGroup.css({'transform':'translate(-200%,0px)'});
      $questionComments.css('visibility','visible');
      break;
  }
});

jQuery(document).on('click', '.comment_edit_button', function() {
  var commentId = $(this).data('edit-comment-id');
  $editForm = $('div[data-comment-id=' + commentId + '] .comment_edit_form');
  $comment = $('p[data-comment-id=' + commentId + ']');

  $editForm.show();
  $comment.hide();
});

jQuery(document).on('click', '.comment_edit_cancel', function() {
  var commentId = $(this).data('edit-comment-cancel-id');
  var commentContent = $('p[data-comment-id=' + commentId + ']').html();
  commentContent = commentContent.replace(/<br>/g, "\n");
  $editForm = $('div[data-comment-id=' + commentId + '] .comment_edit_form');
  $editFormText = $('div[data-comment-id=' + commentId + '] .comment_edit_form textarea');
  $comment = $('p[data-comment-id=' + commentId + ']');

  $editFormText.val(commentContent);
  $editForm.hide();
  $comment.show();
});

jQuery(document).on('click', '.reply_button', function() {
  var commentId = $(this).data('replied-id');
  $replyForm = $('div[data-comment-id=' + commentId + '] .reply_form');

  $replyForm.show();
});

jQuery(document).on('click', '.reply_cancel', function() {
  var commentId = $(this).data('reply-canceled-id');
  $replyForm = $('div[data-comment-id=' + commentId + '] .reply_form');
  $replyFormText = $('div[data-comment-id=' + commentId + '] .reply_form textarea');

  $replyForm.hide();
  $replyFormText.val("");
});

jQuery(document).on('turbolinks:load', function() {
  $imgPrev = $('.img_prev');
  $imgFile = $('.img_file');

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
       $imgPrev.attr('src', e.target.result);
     }
     reader.readAsDataURL(input.files[0]);
    }
  }

  $imgFile.change(function() {
    readURL(this);
  }); 
});
