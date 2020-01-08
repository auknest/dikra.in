<?php foreach ($posts as $post): ?>
  <div class="post-layout <?php echo $j3->classes($post['classes']); ?>">
    <div class="post-thumb">
      <div class="image">
        <a href="<?php echo $post['href']; ?>">
          <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
            <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $post['thumb']; ?>" <?php if ($post['thumb2x']): ?>data-srcset="<?php echo $post['thumb']; ?> 1x, <?php echo $post['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $post['name']; ?>" title="<?php echo $post['name']; ?>" class="img-responsive lazyload"/>
          <?php else: ?>
            <img src="<?php echo $post['thumb']; ?>" <?php if ($post['thumb2x']): ?>srcset="<?php echo $post['thumb']; ?> 1x, <?php echo $post['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $post['name']; ?>" title="<?php echo $post['name']; ?>" class="img-responsive"/>
          <?php endif; ?>
        </a>
      </div>

      <div class="caption">
        <div class="name"><a href="<?php echo $post['href']; ?>"><?php echo $post['name']; ?></a></div>

        <div class="post-stats">
          <span class="p-date"><?php echo $post['date']; ?></span>
          <span class="p-comment"><?php echo $post['comments']; ?></span>
        </div>

      </div>
    </div>
  </div>
<?php endforeach; ?>
