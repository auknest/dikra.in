<?php $context = get_defined_vars(); ?>
<?php if (!function_exists('renderMainMenu')):
  function renderMainMenu($j3, $item, $context) {
    $cid = $j3->uniqueId('collapse-');
    ?>
    <li class="<?php echo $j3->classes($item['classes']); ?>">
      <?php if ($item['items']): ?>
        <?php if ($item['link']['href']): ?>
          <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?> <?php if ($context['display'] == 'dropdown'): ?> class="dropdown-toggle" data-toggle="dropdown" <?php else: ?> class="collapse-toggle"<?php endif; ?>>
            <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
            <span class="open-menu collapsed" data-toggle="collapse" data-target="#<?php echo $cid; ?>"><i class="fa fa-plus"></i></span>
          </a>
        <?php else: ?>
          <a <?php if ($context['display'] == 'dropdown'): ?> class="dropdown-toggle" data-toggle="dropdown" <?php else: ?> class="collapse-toggle"<?php endif; ?>>
            <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
            <span class="open-menu collapsed" data-toggle="collapse" data-target="#<?php echo $cid; ?>"><i class="fa fa-plus"></i></span>
          </a>
        <?php endif; ?>
        <div class="<?php echo $context['display'] == 'dropdown' ? 'dropdown-menu j-dropdown' : 'collapse'; ?>" id="<?php echo $cid; ?>">
          <ul class="j-menu">
            <?php foreach ($item['items'] as $subitem): ?>
              <?php renderMainMenu($j3, $subitem, $context); ?>
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
<?php if ($items): ?>
  <?php $isMobile = $j3->document->hasClass('mobile-header-active'); ?>
  <?php if ($first): ?>
    <div class="menu-trigger menu-item main-menu-item">
      <ul class="j-menu">
        <li><a><?php echo $j3->settings->get('menuTriggerText'); ?></a></li>
      </ul>
    </div>
  <?php endif; ?>
  <div id="<?php echo $id; ?>" class="<?php echo $j3->classes($classes); ?>">
    <ul class="j-menu"><?php foreach ($items as $item): ?>
        <?php $cid = $j3->uniqueId('collapse-'); ?>
        <li class="<?php echo $j3->classes($item['classes']); ?> <?php if ($isMobile && isset($item['isOpen']) && $item['isOpen']): ?>open<?php endif; ?>" <?php if (isset($item['isOpen']) && $item['isOpen']): ?>data-is-open<?php endif; ?>>
          <?php if ($item['items']): ?>
            <?php if ($item['link']['href']): ?>
              <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?> <?php if ($display == 'dropdown'): ?> class="dropdown-toggle" data-toggle="dropdown" <?php else: ?> class="collapse-toggle"<?php endif; ?>>
                <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
                <span class="open-menu collapsed" data-toggle="collapse" data-target="#<?php echo $cid; ?>" <?php if ($isMobile && isset($item['isOpen']) && $item['isOpen']): ?>aria-expanded="true"<?php endif; ?>><i class="fa fa-plus"></i></span>
                <?php if ($item['label']): ?>
                  <span class="menu-label"><?php echo $item['label']; ?></span>
                <?php endif; ?>
              </a>
            <?php else: ?>
              <a <?php if ($display == 'dropdown'): ?> class="dropdown-toggle" data-toggle="dropdown" <?php else: ?> class="collapse-toggle"<?php endif; ?>>
                <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
                <span class="open-menu collapsed" data-toggle="collapse" data-target="#<?php echo $cid; ?>" <?php if ($isMobile && isset($item['isOpen']) && $item['isOpen']): ?>aria-expanded="true"<?php endif; ?>><i class="fa fa-plus"></i></span>
                <?php if ($item['label']): ?>
                  <span class="menu-label"><?php echo $item['label']; ?></span>
                <?php endif; ?>
              </a>
            <?php endif; ?>
            <?php if ($item['type'] == 'multilevel'): ?>
              <div class="<?php echo $display == 'dropdown' ? 'dropdown-menu j-dropdown' : 'collapse'; ?> <?php if ($isMobile && isset($item['isOpen']) && $item['isOpen']): ?>in<?php endif; ?>" id="<?php echo $cid; ?>">
                <ul class="j-menu">
                  <?php foreach ($item['items'] as $subitem): ?>
                    <?php renderMainMenu($j3, $subitem, $context); ?>
                  <?php endforeach; ?>
                </ul>
              </div>
            <?php endif; ?>
            <?php if ($item['type'] == 'megamenu'): ?>
              <div class="<?php echo $display == 'dropdown' ? 'dropdown-menu j-dropdown' : 'collapse'; ?> <?php if ($isMobile && isset($item['isOpen']) && $item['isOpen']): ?>in<?php endif; ?>" id="<?php echo $cid; ?>">
                <div class="mega-menu-content"><?php echo $item['items']; ?></div>
              </div>
            <?php endif; ?>
            <?php if ($item['type'] == 'flyout'): ?>
              <div class="<?php echo $display == 'dropdown' ? 'dropdown-menu j-dropdown' : 'collapse'; ?> <?php if ($isMobile && isset($item['isOpen']) && $item['isOpen']): ?>in<?php endif; ?>" id="<?php echo $cid; ?>">
                <?php echo $item['items']; ?>
              </div>
            <?php endif; ?>
          <?php else: ?>
            <?php if ($item['link']['href']): ?>
              <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>>
                <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
                <?php if ($item['label']): ?>
                  <span class="menu-label"><?php echo $item['label']; ?></span>
                <?php endif; ?>
              </a>
            <?php else: ?>
              <a>
                <?php echo $j3->countBadge($item['title'], $item['link']['total'], $item['link']['classes']); ?>
                <?php if ($item['label']): ?>
                  <span class="menu-label"><?php echo $item['label']; ?></span>
                <?php endif; ?>
              </a>
            <?php endif; ?>
          <?php endif; ?>
        </li>
      <?php endforeach; ?>
    </ul>
  </div>
<?php endif; ?>
