<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderLinksMenu')):
  function renderLinksMenu($j3, $item, $context) {
    ?>
    <li class="<?php echo $j3->classes($item['classes']); ?>">
      <?php if ($item['link']['href']): ?>
        <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>>
          <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
          <?php if (isset($item['label']) && $item['label']): ?>
            <span class="menu-label"><?php echo $item['label']; ?></span>
          <?php endif; ?>
        </a>
      <?php else: ?>
        <a>
          <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
          <?php if (isset($item['label']) && $item['label']): ?>
            <span class="menu-label"><?php echo $item['label']; ?></span>
          <?php endif; ?>
        </a>
      <?php endif; ?>
    </li>
    <?php
  }
endif; ?>
<?php if ($items): ?>
  <div class="<?php echo $j3->classes($classes); ?>">
    <?php if ($title): ?>
      <h3 class="title module-title"><?php echo $title; ?></h3>
    <?php endif; ?>
    <ul class="module-body">
      <?php foreach ($items as $item): ?>
        <?php renderLinksMenu($j3, $item, $context); ?>
      <?php endforeach; ?>
    </ul>
  </div>
<?php endif; ?>
