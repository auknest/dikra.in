<?php if ($items): ?>
  <div class="<?php echo $j3->classes($classes); ?>">
    <ul>
      <?php foreach ($items as $item): ?>
        <li class="<?php echo $j3->classes($item['classes']); ?>">
          <?php if ($item['link']['href']): ?>
            <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>><?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?></a>
          <?php else: ?>
            <a><?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?></a>
          <?php endif; ?>
        </li>
      <?php endforeach; ?>
    </ul>
  </div>
<?php endif; ?>
