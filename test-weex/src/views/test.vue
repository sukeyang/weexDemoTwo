<template>
  <div>
    <app-header></app-header>
    <div class="testBtn">
      <text onclick="click">点击我测试</text>
    </div>
    <list class="list">
      <cell class="cell" v-for="(item,index) in items">
        <button :id="`btn-` + index" :data-method-name="item.methodName" class="item" @click="goMethod(index)">{{ item.content }}</button>
      </cell>
    </list>
  </div>
</template>
<script>
import AppHeader from '../components/app-header.vue'
var modal = weex.requireModule('modal')
var eventModule = weex.requireModule('event'); 
// var globalEvent = weex.require('globalEvent');
var globalEvent = weex.requireModule('globalEvent');

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
        content: "相册",
        methodName: "album"
      }, {
        content: "地图",
        methodName: "map"
      }]
    }
  },
 // ready: function ()  {
 //      globalEvent.addEventListener("geolocation", function (e) {
 //        console.log("get geolocation " + e[""]);
 //        modal.alert({
 //          message: 'message:' + e.key,
 //          duration: 3,
 //          okTitle: '确定'
 //        })
 //    });
 //  },
  methods: {
    goMethod:function (index) {
       var  message ;
      console.log("globalEvent " + globalEvent);

       // message = '' + this.$data.items[index].methodName;
        eventModule.openURL("123",function(ret) {   
      //   nativeLog(ret);

      //     modal.alert({
      //     message: 'message:' + ret,
      //     duration: 3,
      //     okTitle: '确定'
      //   })
      });
         
      globalEvent.addEventListener("geolocation", function (e) {
      console.log("get geolocation " + e[""]);
        modal.alert({
          message: 'message:' + e.key,
          duration: 3,
          okTitle: '确定'
        })
   });
    },
    

//         exports.addEventListener = function (eventName, callback) {
//           globalEvent.addEventListener(eventName, callback);
// },

      // modal.alert({
      //     message: '@weex-module/' + this.$data.items[index].methodName,
      //     duration: 3,
      //     okTitle: '确定'
      //   })
    //     // console.log(event.target.getAttribute("data-methodname"))
    //   // require('@weex-module/' + this.$data.items[index].methodName)
    //    require('weex-components');
 
    click() {
      // require('@weex-module/myModule').printLog("我是一个测试！")

      eventModule.openURL(message,function(ret) {   
        nativeLog(ret);
      });
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
