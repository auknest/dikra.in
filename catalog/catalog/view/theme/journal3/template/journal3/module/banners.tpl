<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderBanner')):
  function renderBanner($j3, $context) {
    foreach ($context['items'] as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>">
        <a <?php if ($item['link']['href']): ?>href="<?php echo $item['link']['href']; ?>"<?php endif; ?> <?php echo $j3->linkAttrs($item['link']); ?>>
          <?php if (0): ?>
            <img src="<?php echo $context['dummy_image']; ?>" data-src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?>data-srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x" <?php endif; ?> alt="<?php echo $item['title']; ?>" width="<?php echo $context['imageDimensions']['width']; ?>" height="<?php echo $context['imageDimensions']['height']; ?>" class="lazyload"/>
          <?php else: ?>
            <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?>srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x" <?php endif; ?> alt="<?php echo $item['title']; ?>" width="<?php echo $context['imageDimensions']['width']; ?>" height="<?php echo $context['imageDimensions']['height']; ?>"/>
          <?php endif; ?>
          <div class="banner-text banner-caption"><span><?php echo $item['title']; ?></span></div>
          <div class="banner-text banner-caption-2"><span><?php echo $item['title2']; ?></span></div>
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
    <?php /* grid */ ?>
    <?php if (!$carousel): ?>
      <?php renderBanner($j3, $context); ?>
    <?php endif; ?>
    <?php /* grid + carousel */ ?>
    <?php if ($carousel): ?>
      <div class="swiper" data-items-per-row='<?php echo json_encode($itemsPerRow, JSON_FORCE_OBJECT); ?>' data-options='<?php echo json_encode($carouselOptions, JSON_FORCE_OBJECT); ?>'>
        <div class="swiper-container" <?php if ($j3->isRTL()): ?>dir="rtl"<?php endif; ?>>
          <div class="swiper-wrapper">
            <?php renderBanner($j3, $context); ?>
          </div>
        </div>
        <div class="swiper-buttons">
          <div class="swiper-button-prev"></div>
          <div class="swiper-button-next"></div>
        </div>
        <div class="swiper-pagination"></div>
      </div>
    <?php endif; ?>
  </div>
</div>
