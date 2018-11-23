<template>
    <a-layout id="components-layout-demo-top" class="layout">
    <a-layout-header>
      <div class="logo">
        <h2>Phone Number Generator</h2>
        </div>
      <a-menu
        theme="dark"
        mode="horizontal"
        :defaultSelectedKeys="['2']"
        :style="{ lineHeight: '64px' }"
      >
      </a-menu>
    </a-layout-header>
    <a-layout-content style="padding: 0 50px">
      <div :style="{ background: '#fff', padding: '24px', height: '95vh' }">
        <div>
          <h3>
            Enter the amount of phone numbers you want to generate
          </h3>
          </div>
        <div>
          <a-input-number :min="1" :max="10000" v-model="value" size="large"/>
          <a-button
            type="primary"
            @click="generatePhone"
            size="large"
            class="btn-generate"
          >Generate Phone Numbers</a-button>
        </div>
        <div v-if="numberSize">
          <a-row>
            <a-col :span="12" :offset="6">
              <RandomNumberDisplay
                :phoneNumbers="phoneNumbers"
                :sortByAsc="sortByAsc"
                :sortByDesc="sortByDesc"
                :getMaximumNumber="getMaximumNumber"
                :getMinimumNumber="getMinimumNumber"
                :totalNumber="totalNumber"
                :savePhoneNumbers="savePhoneNumbers"
              />
            </a-col>
          </a-row>
        </div>
      </div>
    </a-layout-content>
    <a-layout-footer style="text-align: center">
      ©2018 Created by Itua Akhator
    </a-layout-footer>
  </a-layout>
</template>

<script>
import _ from 'lodash'
import saveAs from 'file-saver'
import RandomNumberDisplay from './RandomNumberDisplay'

export default {
  data () {
    return {
      phoneNumbers: [],
      max: 3,
      value: 1,
      fullNumber: null
    }
  },
  components: {
    RandomNumberDisplay
  },
  methods: {
    generateRandomNumber (n) {
      if (n > this.max) {
        return this.generateRandomNumber(this.max)
      }
      return Math.floor(
        Math.pow(10, n - 1) + Math.random() * 9 * Math.pow(10, n - 1)
      )
    },
    generatePhone () {
      this.phoneNumbers = []
      for (let i = 0; i < this.value; i++) {
        if (
          _.findIndex(this.phoneNumbers, {
            phoneNo: this.generateFullPhone()
          }) === -1
        ) {
          this.phoneNumbers.push({
            id: i + 1,
            phoneNo: this.generateFullPhone()
          })
        } else {
          i--
        }
      }
    },
    generateFullPhone () {
      const first = this.generateRandomNumber(3)
      const second = this.generateRandomNumber(3)
      const third = this.generateRandomNumber(3)
      this.fullNumber = `0${first}${second}${third}`
      return this.fullNumber
    },
    sortByAsc () {
      return this.phoneNumbers.sort(this.compareValues('phoneNo'))
    },
    sortByDesc () {
      return this.phoneNumbers.sort(this.compareValues('phoneNo', 'desc'))
    },
    compareValues (key, order = 'asc') {
      return function (a, b) {
        if (!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
          // property doesn't exist on either object
          return 0
        }

        let comparison = 0
        if (a.phoneNo > b.phoneNo) {
          comparison = 1
        } else if (a.phoneNo < b.phoneNo) {
          comparison = -1
        }
        return order === 'desc' ? comparison * -1 : comparison
      }
    },
    savePhoneNumbers (phoneNum) {
      const parse = JSON.stringify(phoneNum, null, 2)
      saveAs(
        new Blob([parse], {
          type: 'application/json;charset=utf-8'
        }),
        'data.json'
      )
    }
  },
  computed: {
    getMaximumNumber () {
      return Array.from(this.phoneNumbers)
        .map(arr => arr.phoneNo)
        .reduce((prev, curr) => (curr > prev ? curr : prev), 0)
    },
    getMinimumNumber () {
      return Array.from(this.phoneNumbers)
        .map(arr => arr.phoneNo)
        .reduce(
          (prev, curr) => (curr < prev ? curr : prev),
          this.phoneNumbers[0]
        )
    },
    totalNumber () {
      return this.phoneNumbers.length
    },
    numberSize () {
      return this.phoneNumbers.length > 0
    }
  }
}
</script>

<style>
#components-layout-demo-top .logo h2{
  width: 100;
  height: 31px;
  color: #ffffff;
  font-weight: bold;
  margin: 5px 24px 16px 0;
  float: left;
}

.ant-input-number-lg {
  margin-right: 22px !important;
  margin-top: 10px !important;
}

.layout {
  margin-top: -70px;
}
</style>
