<?php foreach ($categories as $category): ?>
  <div class="category-layout <?php echo $j3->classes($category['classes']); ?>">
    <div class="category-thumb">
      <div class="image">
        <a href="<?php echo $category['href']; ?>">
          <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
            <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $category['thumb']; ?>" <?php if ($category['thumb2x']): ?>data-srcset="<?php echo $category['thumb']; ?> 1x, <?php echo $category['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" class="img-responsive lazyload"/>
          <?php else: ?>
            <img src="<?php echo $category['thumb']; ?>" <?php if ($category['thumb2x']): ?>srcset="<?php echo $category['thumb']; ?> 1x, <?php echo $category['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" class="img-responsive"/>
          <?php endif; ?>
        </a>
      </div>

      <div class="caption">
        <div class="name"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></div>

        <div class="description"><?php echo $category['description']; ?></div>

        <div class="button-group">
          <a class="btn btn-view-more" href="<?php echo $category['href']; ?>" <?php if (($j3->settings->get('CategoryButtonDisplay') == "icon") && $j3->settings->get('CategoryButtonTooltipStatus')): ?>data-toggle="tooltip" data-tooltip-class="<?php echo $module_id ? 'module-categories-' . $module_id . ' module-categories-grid' : 'category-grid'; ?> view-more-tooltip" data-placement="<?php echo $j3->settings->get('CategoryButtonTooltipPosition'); ?>" title="<?php echo $viewMoreText; ?>"<?php endif; ?>>
            <span class="btn-text"><?php echo $viewMoreText; ?></span>
          </a>
        </div>
      </div>
    </div>
  </div>
<?php endforeach; ?>
