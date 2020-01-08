<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderProducts')):
  function renderProducts($j3, $item, $context) {
    $context['products'] = $item['products'];
    if ($context['carousel']): ?>
      <div class="swiper" data-items-per-row='<?php echo json_encode($context['itemsPerRow'], JSON_FORCE_OBJECT); ?>' data-options='<?php echo json_encode($context['carouselOptions'], JSON_FORCE_OBJECT); ?>'>
        <div class="swiper-container" <?php if ($j3->isRTL()): ?>dir="rtl"<?php endif; ?>>
          <div class="swiper-wrapper product-<?php echo $context['display']; ?>">
            <?php extract($context);
            include $j3->incl('journal3/product_card.tpl'); ?>
          </div>
        </div>
        <div class="swiper-buttons">
          <div class="swiper-button-prev"></div>
          <div class="swiper-button-next"></div>
        </div>
        <div class="swiper-pagination"></div>
      </div>
    <?php else: ?>
      <div class="product-<?php echo $context['display']; ?>">
        <?php extract($context);
        include $j3->incl('journal3/product_card.tpl'); ?>
      </div>
    <?php endif;
  }
endif; ?>
<div class="<?php echo $j3->classes($classes); ?>">
  <div class="module-body">
    <?php /* grid */; ?>
    <?php if ($sectionsDisplay == 'blocks'): ?>
      <?php foreach ($items as $item): ?>
        <div class="<?php echo $j3->classes($item['classes']); ?>">
          <?php if ($item['title']): ?>
            <h3 class="title module-title"><?php echo $item['title']; ?></h3>
          <?php endif; ?>
          <?php renderProducts($j3, $item, $context); ?>
        </div>
      <?php endforeach; ?>
    <?php endif; ?>
    <?php /* tabs */; ?>
    <?php if ($sectionsDisplay == 'tabs'): ?>
      <ul class="nav nav-tabs">
        <?php $index = 1;
        foreach ($items as $item): ?>
          <li class="<?php echo $j3->classes($item['tab_classes']); ?>">
            <?php if (\Journal3\Utils\Arr::get($item, 'link.href')): ?>
              <a href="<?php echo $item['link']['href']; ?>"><?php echo $item['title']; ?></a>
            <?php else: ?>
              <a href="#<?php echo $id; ?>-tab-<?php echo $index; ?>" data-toggle="tab"><?php echo $item['title']; ?></a>
            <?php endif; ?>
          </li>
          <?php $index++; endforeach; ?>
      </ul>
      <div class="tab-content">
        <?php $index = 1;
        foreach ($items as $item): ?>
          <?php if (!\Journal3\Utils\Arr::get($item, 'link.href')): ?>
            <div class="<?php echo $j3->classes($item['classes']); ?>" id="<?php echo $id; ?>-tab-<?php echo $index; ?>">
              <?php renderProducts($j3, $item, $context); ?>
            </div>
          <?php endif; ?>
          <?php $index++; endforeach; ?>
      </div>
    <?php endif; ?>
    <?php /* accordion */; ?>
    <?php if ($sectionsDisplay == 'accordion'): ?>
      <div class="panel-group" id="<?php echo $id; ?>-collapse">
        <?php $index = 0;
        foreach ($items as $item): $index++; ?>
          <div class="<?php echo $j3->classes($item['classes']); ?>">
            <div class="panel-heading">
              <h4 class="panel-title">
                <a href="#<?php echo $id; ?>-collapse-<?php echo $index; ?>" class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#<?php echo $id; ?>-collapse" aria-expanded="false">
                  <?php echo $item['title']; ?>
                  <i class="fa fa-caret-down"></i>
                </a>
              </h4>
            </div>
            <div class="<?php echo $j3->classes($item['panel_classes']); ?>" id="<?php echo $id; ?>-collapse-<?php echo $index; ?>">
              <div class="panel-body">
                <?php renderProducts($j3, $item, $context); ?>
              </div>
            </div>
          </div>
        <?php endforeach; ?>
      </div>
    <?php endif; ?>
    <?php /* isotope */; ?>
    <?php if ($sectionsDisplay == 'isotope'): ?>
      <ul class="nav nav-tabs">
        <?php $index = 1;
        foreach ($items as $item): ?>
          <li class="<?php echo $j3->classes($item['tab_classes']); ?>">
            <a data-filter=".<?php echo $id; ?>-section-<?php echo $index++; ?>"><?php echo $item['title']; ?></a>
          </li>
        <?php endforeach; ?>
      </ul>
      <div class="product-grid isotope-grid">
        <?php include $j3->incl('journal3/product_card.tpl'); ?>
      </div>
    <?php endif; ?>
  </div>
</div>
