<template>
  <div>
    <div class="max-min">
      <div class="min-max-total"><span>max: {{ getMaximumNumber }},</span><span>min: {{ getMinimumNumber }},</span><span>total number generated: {{totalNumber}}</span></div>
    </div>
    <div class="btn-sort">
      <a-button class="asc" type="primary" @click="sortByAsc">Sort in Ascending</a-button>
      <a-button class="desc" type="primary" @click="sortByDesc">Sort in Desc</a-button>
      <a-button type="primary" class="saveNumbers" @click="savePhoneNumbers(phoneNumbers);"
        >Save Numbers</a-button
      >
    </div>
    <a-table :columns="columns" :dataSource="phoneNumbers" bordered> </a-table>
  </div>
</template>

<script>
export default {
  props: ['phoneNumbers', 'sortByAsc', 'sortByDesc', 'getMaximumNumber', 'getMinimumNumber', 'totalNumber', 'savePhoneNumbers'],
  data () {
    return {
      columns: [
        {
          title: 'Id',
          dataIndex: 'id',
          scopedSlots: { customRender: 'id' }
        },
        {
          title: 'Phone Numbers',
          className: 'column-money',
          dataIndex: 'phoneNo',
          scopedSlots: { customRender: 'phoneNo' }
        }
      ]
    }
  }
}
</script>

<style>
th.column-money,
td.column-money {
  text-align: right !important;
}

.ant-table-empty .ant-table-body {
  overflow: auto !important;
  margin-top: 10px;
}

.ant-table, .ant-table-default, .ant-table-content {
  margin-top: 10px;
}

.max-min {
  margin: 30px 20px;
  border-radius: 3px;
  padding: 5px;
  box-shadow: 0px 3px 1px -2px rgba(0,0,0,0.2), 0px 2px 2px 0px rgba(0,0,0,0.14), 0px 1px 5px 0px rgba(0,0,0,0.12);
}

.min-max-total span{
  margin-right: 10px;
  font-size: 17px;
}

.btn-sort .asc {
  margin-right: 20px
}

.btn-sort .desc {
  margin-right: 20px
}
</style>
