<?php foreach ($posts as $post): ?>
  <div class="post-layout <?php echo $j3->classes($post['classes']); ?>">
    <div class="post-thumb">
      <div class="image">
        <?php if ($j3->settings->get('datePosition') === 'image'): ?>
          <span class="p-date p-date-image"><?php echo $post['date']; ?></span>
        <?php endif; ?>
        <a href="<?php echo $post['href']; ?>">
          <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
            <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $post['thumb']; ?>" <?php if ($post['thumb2x']): ?>data-srcset="<?php echo $post['thumb']; ?> 1x, <?php echo $post['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $post['name']; ?>" title="<?php echo $post['name']; ?>" class="img-responsive lazyload"/>
          <?php else: ?>
            <img src="<?php echo $post['thumb']; ?>" <?php if ($post['thumb2x']): ?>srcset="<?php echo $post['thumb']; ?> 1x, <?php echo $post['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $post['name']; ?>" title="<?php echo $post['name']; ?>" class="img-responsive"/>
          <?php endif; ?>
        </a>
      </div>

      <div class="caption">

        <div class="post-stats">
          <span class="p-author"><?php echo $post['author']; ?></span>
          <?php if ($j3->settings->get('datePosition') === 'default'): ?>
            <span class="p-date p-date-default"><?php echo $post['date']; ?></span>
          <?php endif; ?>
          <span class="p-comment"><?php echo $post['comments']; ?></span>
          <span class="p-view"><?php echo $post['views']; ?></span>
        </div>

        <div class="name"><a href="<?php echo $post['href']; ?>"><?php echo $post['name']; ?></a></div>

        <div class="description"><?php echo $post['description']; ?></div>

        <div class="button-group">
          <a class="btn btn-read-more" href="<?php echo $post['href']; ?>" <?php if (($j3->settings->get('PostGridButtonDisplay') == "icon") && ($j3->settings->get('PostGridButtonTooltipStatus'))): ?>data-toggle="tooltip" data-tooltip-class="<?php echo $module_id ? 'module-blog_posts-' . $module_id . ' module-blog_posts-grid' : 'post-grid'; ?> read-more-tooltip" data-placement="<?php echo $j3->settings->get('PostGridButtonTooltipPosition'); ?>" title="<?php echo $j3->settings->get('blogReadMoreButtonText'); ?>" <?php endif; ?>>
            <span class="btn-text"><?php echo $j3->settings->get('blogReadMoreButtonText'); ?></span>
          </a>
        </div>
      </div>
    </div>
  </div>
<?php endforeach; ?>
