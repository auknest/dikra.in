<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderAccordionMenu')):
  function renderAccordionMenu($j3, $item, $context) {
    $isOpen = isset($item['isOpen']) && $item['isOpen'];
    ?>
    <li class="<?php echo str_replace('dropdown', '', $j3->classes($item['classes'])); ?>">
      <?php $id = $j3->uniqueId('collapse-'); ?>
      <?php if ($item['link']['href']): ?>
        <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>>
          <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
          <?php if ($item['items']): ?>
            <?php if ($isOpen): ?>
              <span class="open-menu" data-toggle="collapse" data-target="#<?php echo $id; ?>" aria-expanded="true" role="heading"><i class="fa fa-plus"></i></span>
            <?php else: ?>
              <span class="open-menu collapsed" data-toggle="collapse" data-target="#<?php echo $id; ?>" role="heading"><i class="fa fa-plus"></i></span>
            <?php endif; ?>
          <?php endif; ?>
        </a>
      <?php else: ?>
        <a>
          <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
          <?php if ($item['items']): ?>
            <?php if ($isOpen): ?>
              <span class="open-menu" data-toggle="collapse" data-target="#<?php echo $id; ?>" aria-expanded="true" role="heading"><i class="fa fa-plus"></i></span>
            <?php else: ?>
              <span class="open-menu collapsed" data-toggle="collapse" data-target="#<?php echo $id; ?>" role="heading"><i class="fa fa-plus"></i></span>
            <?php endif; ?>
          <?php endif; ?>
        </a>
      <?php endif; ?>
      <?php if ($item['items']): ?>
        <div class="collapse <?php if ($isOpen): ?>in<?php endif; ?>" id="<?php echo $id; ?>">
          <ul class="j-menu">
            <?php foreach ($item['items'] as $subitem): ?>
              <?php renderAccordionMenu($j3, $subitem, $context); ?>
            <?php endforeach; ?>
          </ul>
        </div>
      <?php endif; ?>
    </li>
    <?php
  }
endif; ?>
<div class="<?php echo $j3->classes($classes); ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <ul class="j-menu">
    <?php foreach ($items as $item): ?>
      <?php renderAccordionMenu($j3, $item, $context); ?>
    <?php endforeach; ?>
  </ul>
</div>
