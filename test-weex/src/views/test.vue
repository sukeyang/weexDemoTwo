<template>
  <div>
    <app-header></app-header>
    <div class="testBtn">
      <text onclick="click">点击我测试</text>
    </div>
    <list class="list">
      <cell class="cell" v-for="item in items">
        <button class="item" @click="goMethod">{{ item.content }}</button>
      </cell>
    </list>
  </div>
</template>
<script>
import AppHeader from '../components/app-header.vue'

export default {
  components: {
    AppHeader
  },
  data() {
    return {
      items: [{
        content: "扫码",
        methodName: "qrcode"
      }, {
        content: "GPS",
        methodName: "gps"
      }, {
        content: "获取session",
        methodName: "getSession"
      }, {
        content: "显示session",
        methodName: "showSession"
      }, {
        content: "相册",
        methodName: "album"
      }, {
        content: "地图",
        methodName: "map"
      }]
    }
  },
  methods: {
    goMethod(event) {
      debugger
    },
    click() {
      require('@weex-module/myModule').printLog("我是一个测试！")
    }
  }
}
</script>
<style scoped>
.cell {
  height: 60px;
  padding: 10px 20px;
  border-style: solid;
  border-width: 2px;
  border-color: red;
  justify-content: center;
  border-left: 0;
  border-top: 0;
  height: 100px;
  box-sizing: content-box;
  border-right: 0;
}

.item {
  font-size: 50px;
}

.testBtn {
  font-size: 50px;
  height: 80px;
  background-color: red;
}
</style>
