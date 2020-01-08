<div class="<?php echo $j3->classes($classes); ?>">
  <?php if ($link['href']): ?>
    <a class="btn" href="<?php echo $link['href']; ?>" <?php echo $j3->linkAttrs($link); ?>><?php echo $title; ?></a>
  <?php else: ?>
    <a class="btn"><?php echo $title; ?></a>
  <?php endif; ?>
</div>
