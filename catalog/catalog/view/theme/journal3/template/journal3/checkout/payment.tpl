<div class="panel-group payment-panel-group" v-bind:class="[order_info.payment_method ? 'payment-' + order_info.payment_method : '']">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title"><a>Payment</a></h4>
    </div>
    <div class="panel-collapse">
      <div class="panel-body">
        <payment></payment>
      </div>
    </div>
  </div>
</div>
