<?php if ($attribute_groups): ?>
  <div id="tab-specification">
    <div class="table-responsive">
        <table class="table table-bordered">
            <?php foreach ($attribute_groups as $attribute_group): ?>
                <thead>
                <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($attribute_group['attribute'] as $attribute): ?>
                    <tr>
                        <td><?php echo $attribute['name']; ?></td>
                        <td><?php echo $attribute['text']; ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            <?php endforeach; ?>
        </table>
    </div>
  </div>
<?php endif; ?>
