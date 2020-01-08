<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderGallery')):
  function renderGallery($j3, $context) {
    $index = 0;
    $items = array_slice($context['items'], 0, $context['thumbsLimit']);
    foreach ($items as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>">
        <a <?php if ($item['type'] != 'link'): ?>data-gallery="#<?php echo $context['id']; ?> .lightgallery" data-index="<?php echo $index++; ?>"<?php endif; ?> href="<?php echo $item['popup']; ?>" title="<?php echo $item['alt']; ?>">
          <span>
            <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
              <img src="<?php echo $context['dummy_image']; ?>" data-src="<?php echo $item['thumb']; ?>" <?php if (isset($item['thumb2x']) && $item['thumb2x']): ?>data-srcset="<?php echo $item['thumb']; ?> 1x, <?php echo $item['thumb2x']; ?> 2x"<?php endif; ?> alt="<?php echo $item['alt']; ?>" width="<?php echo $context['thumbDimensions']['width']; ?>" height="<?php echo $context['thumbDimensions']['height']; ?>" class="lazyload"/>
            <?php else: ?>
              <img src="<?php echo $item['thumb']; ?>" <?php if (isset($item['thumb2x']) && $item['thumb2x']): ?>srcset="<?php echo $item['thumb']; ?> 1x, <?php echo $item['thumb2x']; ?> 2x"<?php endif; ?> alt="<?php echo $item['alt']; ?>" width="<?php echo $context['thumbDimensions']['width']; ?>" height="<?php echo $context['thumbDimensions']['height']; ?>"/>
            <?php endif; ?>
          </span>
        </a>
      </div>
    <?php endforeach;
  }
endif; ?>
<div id="<?php echo $id; ?>" class="<?php echo $j3->classes($classes); ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <div class="module-body">
    <?php if ($button): ?>
      <a class="btn open-btn" data-gallery="#<?php echo $id; ?> .lightgallery" data-index="0"><?php echo $buttonText; ?></a>
    <?php else: ?>
      <?php /* grid */ ?>
      <?php if (!$carousel): ?>
        <?php renderGallery($j3, $context); ?>
      <?php endif; ?>
      <?php /* grid + carousel */ ?>
      <?php if ($carousel): ?>
        <div class="swiper" data-items-per-row='<?php echo json_encode($itemsPerRow, JSON_FORCE_OBJECT); ?>' data-options='<?php echo json_encode($carouselOptions, JSON_FORCE_OBJECT); ?>'>
          <div class="swiper-container" <?php if ($j3->isRTL()): ?>dir="rtl"<?php endif; ?>>
            <div class="swiper-wrapper">
              <?php renderGallery($j3, $context); ?>
            </div>
          </div>
          <div class="swiper-buttons">
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
          </div>
          <div class="swiper-pagination"></div>
        </div>
      <?php endif; ?>
    <?php endif; ?>
  </div>
  <div class="lightgallery" data-images='<?php echo htmlspecialchars(json_encode($images), ENT_QUOTES, 'UTF-8'); ?>' data-options='<?php echo json_encode($options, JSON_FORCE_OBJECT); ?>'></div>
</div>
