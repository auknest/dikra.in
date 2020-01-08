<?php foreach ($manufacturers as $manufacturer): ?>
  <div class="manufacturer-layout <?php echo $j3->classes($manufacturer['classes']); ?>">
    <div class="manufacturer-thumb">
      <div class="image">
        <a href="<?php echo $manufacturer['href']; ?>">
          <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
            <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $manufacturer['thumb']; ?>" <?php if ($manufacturer['thumb2x']): ?>data-srcset="<?php echo $manufacturer['thumb']; ?> 1x, <?php echo $manufacturer['thumb2x']; ?> 2x"<?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $manufacturer['name']; ?>" title="<?php echo $manufacturer['name']; ?>" class="lazyload"/>
          <?php else: ?>
            <img src="<?php echo $manufacturer['thumb']; ?>" <?php if ($manufacturer['thumb2x']): ?>srcset="<?php echo $manufacturer['thumb']; ?> 1x, <?php echo $manufacturer['thumb2x']; ?> 2x"<?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $manufacturer['name']; ?>" title="<?php echo $manufacturer['name']; ?>"/>
          <?php endif; ?>
        </a>
      </div>

      <div class="caption">
        <div class="name"><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></div>
      </div>
    </div>
  </div>
<?php endforeach; ?>
