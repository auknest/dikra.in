<script>
  console.table(<?php echo json_encode($stats); ?>);
  console.info('TTFB: ', '<?php echo ($ttfb); ?> ms');
</script>
