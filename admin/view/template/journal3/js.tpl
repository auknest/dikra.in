<?php foreach ($data as $key => $value): ?>
<?php if (is_scalar($value)): ?>
window['_oc_<?php echo $key; ?>'] = '<?php echo $value; ?>';
<?php else: ?>
window['_oc_<?php echo $key; ?>'] = <?php echo json_encode($value); ?>;
<?php endif; ?>
<?php endforeach; ?>
