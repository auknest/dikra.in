<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderCatalog')):
  function renderCatalog($j3, $context) {
    foreach ($context['items'] as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>">
        <div class="item-content">
          <a href="<?php echo $item['href']; ?>" class="catalog-title"><?php echo $item['name']; ?></a>
          <div class="item-assets image-left">
            <?php if ($item['image']): ?>
              <a href="<?php echo $item['href']; ?>" class="catalog-image">
                <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
                  <img src="<?php echo $context['dummy_image']; ?>" data-src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?>data-srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x"<?php endif; ?> alt="<?php echo $item['name']; ?>" width="<?php echo $context['imageDimensions']['width']; ?>" height="<?php echo $context['imageDimensions']['height']; ?>" class="lazyload"/>
                <?php else: ?>
                  <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?>srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x"<?php endif; ?> alt="<?php echo $item['name']; ?>" width="<?php echo $context['imageDimensions']['width']; ?>" height="<?php echo $context['imageDimensions']['height']; ?>"/>
                <?php endif; ?>
              </a>
            <?php endif; ?>
            <div class="subitems">
              <?php foreach ($item['items'] as $sub_item): ?>
                <div class="subitem" data-image="<?php echo $sub_item['image']; ?>" <?php if (isset($sub_item['image2x']) && $sub_item['image2x']): ?>data-image2x="<?php echo $sub_item['image']; ?> 1x, <?php echo $sub_item['image2x']; ?> 2x"<?php endif; ?>>
                  <a href="<?php echo $sub_item['href']; ?>"><span><?php echo $sub_item['name']; ?></span></a>
                </div>
              <?php endforeach; ?>
              <?php if ($item['total'] > count($item['items'])): ?>
                <div class="subitem view-more">
                  <a href="<?php echo $item['href']; ?>"><span><?php echo $context['viewMoreText']; ?></span></a>
                </div>
              <?php endif; ?>
            </div>
          </div>
        </div>
      </div>
    <?php endforeach;
  }
endif; ?>
<div class="<?php echo $j3->classes($classes); ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <div class="module-body">
    <?php if ($carousel): ?>
      <div class="swiper" data-items-per-row='<?php echo json_encode($itemsPerRow, JSON_FORCE_OBJECT); ?>' data-options='<?php echo json_encode($carouselOptions, JSON_FORCE_OBJECT); ?>'>
        <div class="swiper-container" <?php if ($j3->isRTL()): ?>dir="rtl"<?php endif; ?>>
          <div class="swiper-wrapper">
            <?php renderCatalog($j3, $context); ?>
          </div>
        </div>
        <div class="swiper-buttons">
          <div class="swiper-button-prev"></div>
          <div class="swiper-button-next"></div>
        </div>
        <div class="swiper-pagination"></div>
      </div>
    <?php else: ?>
      <?php renderCatalog($j3, $context); ?>
    <?php endif; ?>
  </div>
</div>

