<?php if ($items): ?>
  <div class="<?php echo $j3->classes($classes); ?>">
    <?php if ($title): ?>
      <h3 class="title module-title"><?php echo $title; ?></h3>
    <?php endif; ?>
    <ul>
      <?php foreach ($items as $item): ?>
        <li class="<?php echo $j3->classes($item['classes']); ?>">
          <?php if ($item['link']['href']): ?>
            <a <?php if ($tooltipStatus): ?>data-toggle="tooltip" data-tooltip-class="icons-menu-tooltip-<?php echo $module_id; ?>" data-placement="<?php echo $tooltipPosition; ?>" title="<?php echo $item['title']; ?>"<?php endif; ?> href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>>
              <?php if ($item['type'] === 'image'): ?>
                <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?> srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x" <?php endif; ?> width="<?php echo $imageDimensions['width']; ?>" height="<?php echo $imageDimensions['height']; ?>" alt="<?php echo $item['title']; ?>" class="info-block-img"/>
              <?php endif; ?>
              <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
            </a>
          <?php else: ?>
            <a>
              <?php if ($item['type'] === 'image'): ?>
                <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?> srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x" <?php endif; ?> width="<?php echo $imageDimensions['width']; ?>" height="<?php echo $imageDimensions['height']; ?>" alt="<?php echo $item['title']; ?>" class="info-block-img"/>
              <?php endif; ?>
              <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
            </a>
          <?php endif; ?>
        </li>
      <?php endforeach; ?>
    </ul>
  </div>
<?php endif; ?>
