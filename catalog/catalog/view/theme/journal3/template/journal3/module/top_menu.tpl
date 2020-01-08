<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderTopMenu')):
  function renderTopMenu($j3, $item, $context) {
    ?>
    <li class="<?php echo $j3->classes($item['classes']); ?>">
      <?php if ($item['items']): ?>
        <?php if ($item['link']['href']): ?>
          <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?> class="dropdown-toggle" data-toggle="dropdown"><?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?></a>
        <?php else: ?>
          <a class="dropdown-toggle" data-toggle="dropdown"><?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?></a>
        <?php endif; ?>
        <div class="dropdown-menu j-dropdown">
          <ul class="j-menu">
            <?php foreach ($item['items'] as $subitem): ?>
              <?php renderTopMenu($j3, $subitem, $context); ?>
            <?php endforeach; ?>
          </ul>
        </div>
      <?php else: ?>
        <?php if ($item['link']['href']): ?>
          <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>><?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?></a>
        <?php else: ?>
          <a><?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?></a>
        <?php endif; ?>
      <?php endif; ?>
    </li>
    <?php
  }
endif; ?>
<div class="<?php echo $j3->classes($classes); ?>">
  <ul class="j-menu">
    <?php foreach ($items as $item): ?>
      <?php renderTopMenu($j3, $item, $context); ?>
    <?php endforeach; ?>
  </ul>
</div>
