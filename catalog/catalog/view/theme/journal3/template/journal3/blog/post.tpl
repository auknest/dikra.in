<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  <h1 class="title page-title"><span><?php echo $post_name; ?></span></h1>
<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div class="container blog-post">
  <div class="row"><?php echo $column_left; ?>
    <div id="content">
      <?php if ($j3->settings->get('pageTitlePosition') === 'default'): ?>
        <h1 class="title page-title"><?php echo $post_name; ?></h1>
      <?php endif; ?>
      <?php echo $content_top; ?>
      <div class="post-details">
        <div class="post-image">
          <?php if ($j3->settings->get('datePosition') === 'image'): ?>
            <span class="p-date p-date-image"><?php echo date($date_format_short, strtotime($post_date)); ?></span>
          <?php endif; ?>
          <img src="<?php echo $post_image; ?>" <?php if ($post_image2x): ?> srcset="<?php echo $post_image; ?> 1x, <?php echo $post_image2x; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $post_name; ?>" title="<?php echo $post_name; ?>"/>
        </div>
        <div class="post-stats">
          <?php if ($post_author): ?>
            <span class="p-posted"><?php echo $j3->settings->get('blogPostedByText'); ?></span>
            <span class="p-author"><?php echo $post_author; ?></span>
          <?php endif; ?>
          <?php if ($j3->settings->get('datePosition') === 'default'): ?>
            <span class="p-date p-date-default"><?php echo date($date_format_short, strtotime($post_date)); ?></span>
          <?php endif; ?>
          <span class="p-comment"><?php echo count($comments) ?> <?php echo $j3->settings->get('blogCommentsText'); ?></span>
          <span class="p-view"><?php echo $post_views; ?> <?php echo $j3->settings->get('blogViewsText'); ?></span>
          <?php if ($post_categories): ?>
            <span class="p-category">
          <?php foreach ($post_categories as $index => $category): ?>
            <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
            <?php if ($index < count($post_categories) - 1): ?>
              <b>,</b>
            <?php endif; ?>
          <?php endforeach; ?>
          </span>
          <?php endif; ?>
        </div>
       <div class="post-content">
         <?php echo $post_content; ?>
       </div>
        <?php if ($post_tags): ?>
          <div class="tags">
            <span class="tags-title"><?php echo $text_tags; ?></span>
            <?php foreach ($post_tags as $tag): ?>
              <a href="<?php echo $tag['href']; ?>"><?php echo $tag['name']; ?></a><b>,</b>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>
      </div>

      <?php echo $content_bottom; ?>

      <?php if ($allow_comments): ?>
        <div class="post-comments">
          <?php if (count($comments) > 0): ?>
            <h3 class="title"><?php echo count($comments); ?> <?php echo $j3->settings->get('blogCommentsText'); ?></h3>
          <?php endif; ?>
          <?php foreach ($comments as $comment): ?>
            <div class="post-comment" data-comment-id="<?php echo $comment['comment_id']; ?>" data-has-form="false">
              <img class="user-avatar" src="https://s.gravatar.com/avatar/<?php echo $comment['avatar']; ?>?s=<?php echo $j3->settings->get('postCommentImageSize'); ?>" width="<?php echo $j3->settings->get('postCommentImageSize'); ?>" height="<?php echo $j3->settings->get('postCommentImageSize'); ?>" alt="">
              <div class="comment">
                <div class="user-name"><?php echo $comment['name']; ?>:</div>
                <div class="user-data">
                  <div>
                    <span class="user-date p-date"><?php echo date($date_format_short, strtotime($comment['date'])); ?></span>
                    <span class="user-time p-time"><?php echo date($time_format, strtotime($comment['date'])); ?></span>
                  </div>
                  <?php if ($comment['website']): ?>
                    <span class="user-site p-site"><a href="<?php echo $comment['website']; ?>" target="_blank"><?php echo $comment['website']; ?></a></span>
                  <?php endif; ?>
                </div>
                <a class="btn reply-btn"><?php echo $j3->settings->get('blogReplyText'); ?></a>
                <p><?php echo $comment['comment']; ?></p>
                <?php foreach ($comment['replies'] as $reply): ?>
                  <div class="post-reply">
                    <img class="user-avatar" src="https://s.gravatar.com/avatar/<?php echo $comment['avatar']; ?>?s=<?php echo $j3->settings->get('postCommentImageSize'); ?>" width="<?php echo $j3->settings->get('postCommentImageSize'); ?>" height="<?php echo $j3->settings->get('postCommentImageSize'); ?>" alt="">
                    <div class="comment">
                      <div class="user-name"><?php echo $reply['name']; ?>:</div>
                      <div class="user-data">
                        <div>
                          <span class="user-date p-date"><?php echo date($date_format_short, strtotime($reply['date'])); ?></span>
                          <span class="user-time p-time"><?php echo date($time_format, strtotime($reply['date'])); ?></span>
                        </div>
                        <?php if ($reply['website']): ?>
                          <span class="user-site p-site"><a href="<?php echo $reply['website']; ?>" target="_blank"><?php echo $reply['website']; ?></a></span>
                        <?php endif; ?>
                      </div>
                      <p><?php echo $reply['comment']; ?></p>
                    </div>
                  </div>
                <?php endforeach; ?>
              </div>
            </div>
          <?php endforeach; ?>
          <div class="comment-form">
            <h3 class="title"><?php echo $j3->settings->get('blogLeaveCommentText'); ?></h3>
            <form method="post" enctype="multipart/form-data" class="form-horizontal">
              <fieldset>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="name" value="<?php echo $default_name; ?>" id="input-name" class="form-control"/>
                  </div>
                </div>

                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="email" value="<?php echo $default_email; ?>" id="input-email" class="form-control"/>

                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-website"><?php echo $entry_website; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="website" value="<?php echo $default_website; ?>" id="input-website" class="form-control"/>
                  </div>
                </div>

                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-comment"><?php echo $text_comment; ?></label>
                  <div class="col-sm-10">
                    <textarea name="comment" rows="10" id="input-comment" class="form-control"><?php echo $default_comment; ?></textarea>
                  </div>
                </div>
              </fieldset>
              <div class="buttons">
                <div class="pull-right">
                  <button type="button" class="btn comment-submit"><?php echo $button_submit; ?></button>
                </div>
              </div>
            </form>
          </div>
        </div>
      <?php endif; ?>

      </div>
    <?php echo $column_right; ?></div>
  <?php if ($allow_comments): ?>
    <script type="text/javascript">
      function generateComment($form, cls, $appendTo, callback) {
        $form.find('.has-error').removeClass('has-error');

        $.post('index.php?route=journal3/blog/comment&post_id=<?php echo $post_id; ?>', $form.serializeArray(), function (response) {
          if (response.status === 'success') {
            if (response.response.data) {
              var html = '';

              html += '<div class="' + cls + '" data-comment-id="' + response.response.data.comment_id + '" data-has-form="false">';
              html += ' <img class="user-avatar" src="https://s.gravatar.com/avatar/' + response.response.data.avatar + '?s=<?php echo $j3->settings->get('postCommentImageSize'); ?>" width="<?php echo $j3->settings->get('postCommentImageSize'); ?>" height="<?php echo $j3->settings->get('postCommentImageSize'); ?>" alt="">';
              html += ' <div class="comment">';
              html += '   <div class="user-name">' + response.response.data.name + ':</div>';
              html += '   <div class="user-data">';
              html += '     <div>';
              html += '       <span class="user-date p-date">' + response.response.data.date + '</span>';
              html += '       <span class="user-time p-time">' + response.response.data.time + '</span>';
              html += '     </div>';
              html += '     <span class="user-site p-site"><a href="' + response.response.data.website + '" target="_blank">' + response.response.data.website + '</a></span>';
              html += '   </div>';

              if (cls === 'post-comment') {
                html += ' <a class="btn reply-btn"><?php echo $j3->settings->get('blogReplyText'); ?></a>';
              }

              html += ' <p>' + response.response.data.comment + '</p>';
              html += '</div>';

              $appendTo.before(html);
            }

            callback && callback(response.response.message);
          }

          if (response.status === 'error') {
            $.each(response.response.errors, function (field) {
              $form.find('[name="' + field + '"]').closest('.form-group').addClass('has-error');
            });
          }
        }, 'json');
      }

      $(document).delegate('.reply-btn', 'click', function () {
        var $comment = $(this).closest('.post-comment');

        if ($comment.attr('data-has-form') === 'false') {
          var $form = $('.post-comments form').clone();
          $form.find('.has-error').removeClass('has-error');
          $form.append('<input type="hidden" name="parent_id" value="' + $comment.attr('data-comment-id') + '" />');
          $form.find('button').removeClass('comment-submit').addClass('reply-submit');
          $comment.find('> .comment').append('<div class="reply-form"><h3 class="title">' + '<?php echo $j3->settings->get('blogLeaveReplyText'); ?>' + '</h3><div class="comment-form"><div><form class="form-horizontal">' + $form.html() + '</form></div></div></div>');
          $comment.attr('data-has-form', 'true');
        } else {
          $comment.find('.reply-form').remove();
          $comment.attr('data-has-form', 'false');
        }
      });

      $(document).delegate('form .comment-submit', 'click', function () {
        var $form = $(this).closest('form');
        var $comment_form = $('.comment-form');

        generateComment($form, 'post-comment', $comment_form, function (message) {
          $comment_form.before('<div class="success">' + message + '</div>');
          setTimeout(function () {
            $('.post-comments .success').slideUp(400, function () {
              $(this).remove();
            });
          }, 1500);
          $form[0].reset();
        });
      });

      $(document).delegate('form .reply-submit', 'click', function () {
        var $form = $(this).closest('form');
        var $reply_form = $(this).closest('.post-comment').find('.reply-form');

        generateComment($form, 'post-reply', $reply_form, function (message) {
          $reply_form.before('<div class="success">' + message + '</div>');
          setTimeout(function () {
            $('.post-comments .success').slideUp(400, function () {
              $(this).remove();
            });
          }, 1500);
          $form.closest('.post-comment').attr('data-has-form', 'false');
          $reply_form.remove();
        });
      });
    </script>
  <?php endif; ?>
</div>
<?php echo $footer; ?>
