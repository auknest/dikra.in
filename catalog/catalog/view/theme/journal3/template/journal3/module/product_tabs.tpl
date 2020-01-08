<?php if ($display === 'tabs'): ?>
  <div class="tabs-container <?php echo $j3->classes($classes); ?>">
    <ul class="nav nav-tabs">
      <?php foreach ($items as $item): ?>
        <li class="<?php echo $j3->classes($item['tab_classes']); ?>">
          <?php if (\Journal3\Utils\Arr::get($item, 'link.href')): ?>
            <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>><?php echo $item['title']; ?></a>
          <?php else: ?>
            <a href="#<?php echo $item['id']; ?>" data-toggle="tab"><?php echo $item['title']; ?></a>
          <?php endif; ?>
        </li>
      <?php endforeach; ?>
    </ul>
    <div class="tab-content">
      <?php foreach ($items as $item): ?>
        <div class="<?php echo $j3->classes($item['classes']); ?>" id="<?php echo $item['id']; ?>">
          <div class="block-body expand-block">
            <div class="block-wrapper">
              <div class="block-content <?php if ($item['expandButton']): ?>expand-content<?php endif; ?>">
                <?php echo $item['content']; ?>
                <?php if ($item['expandButton']): ?>
                <div class="block-expand-overlay"><a class="block-expand btn"></a></div>
                <?php endif; ?>
              </div>
            </div>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
<?php elseif ($display === 'accordion'): ?>
  <div class="panel-group <?php echo $j3->classes($classes); ?>">
    <?php foreach ($items as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a href="#<?php echo $item['id']; ?>" class="accordion-toggle collapsed" data-toggle="collapse" aria-expanded="false">
              <?php echo $item['title']; ?>
              <i class="fa fa-caret-down"></i>
            </a>
          </h4>
        </div>
        <div class="<?php echo $j3->classes($item['panel_classes']); ?>" id="<?php echo $item['id']; ?>">
          <div class="panel-body expand-block">
            <div class="block-wrapper">
              <div class="block-content <?php if ($item['expandButton']): ?>expand-content<?php endif; ?>">
                <?php echo $item['content']; ?>
                <?php if ($item['expandButton']): ?>
                <div class="block-expand-overlay"><a class="block-expand btn"></a></div>
                <?php endif; ?>
              </div>
            </div>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
<?php else: ?>
  <div class="<?php echo $j3->classes($classes); ?>">
    <?php foreach ($items as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>">
        <div class="block-body expand-block">
          <div class="block-wrapper">
            <div class="block-content <?php if ($item['expandButton']): ?>expand-content<?php endif; ?>">
              <?php echo $item['content']; ?>
              <?php if ($item['expandButton']): ?>
              <div class="block-expand-overlay"><a class="block-expand btn"></a></div>
              <?php endif; ?>
            </div>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
<?php endif; ?>
