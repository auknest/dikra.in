<div class="<?php echo $j3->classes($classes); ?>">
  <div class="module-body">
    <?php foreach ($items as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>">
        <?php if ($item['link']['href']): ?>
          <a href="<?php echo $item['link']['href']; ?>" class="info-block" <?php echo $j3->linkAttrs($item['link']); ?>>
            <?php if ($item['type'] === 'image'): ?>
              <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?> srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x" <?php endif; ?> width="<?php echo $imageDimensions['width']; ?>" height="<?php echo $imageDimensions['height']; ?>" alt="<?php echo $item['title']; ?>" class="info-block-img"/>
            <?php endif; ?>
            <div class="info-block-content">
              <div class="info-block-title"><?php echo $item['title']; ?></div>
              <div class="info-block-text"><?php echo $item['content']; ?></div>
            </div>
            <?php if ($item['link']['total'] !== null): ?>
              <span class="count-badge"><?php echo $item['link']['total']; ?></span>
            <?php endif; ?>
          </a>
        <?php else: ?>
          <div class="info-block">
            <?php if ($item['type'] === 'image'): ?>
              <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?> srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x" <?php endif; ?> width="<?php echo $imageDimensions['width']; ?>" height="<?php echo $imageDimensions['height']; ?>" alt="<?php echo $item['title']; ?>" class="info-block-img"/>
            <?php endif; ?>
            <div class="info-block-content">
              <div class="info-block-title"><?php echo $item['title']; ?></div>
              <div class="info-block-text"><?php echo $item['content']; ?></div>
            </div>
          </div>
        <?php endif; ?>
      </div>
    <?php endforeach; ?>
  </div>
</div>
