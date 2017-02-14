<template>
<div style="width: 100%;">
  <app-header></app-header> 
  <div class="cnt">
    <list class="list">
      <cell class="cell" v-for="num in listData">
        <div class="panel" @click="jump(`${num.url}`)">
          <text class="text">{{num.text}}</text>
        </div>
      </cell>
    </list>
</div>
</div>


</template>

<style scoped>
  .cnt {
    width:100%;
    display: block;
    position: relative;
    overflow-x: hidden;
    overflow-y: scroll;
  }
  .list li {font-size: 40px;display: inline-block;width:100%;height:60px;text-align: center;margin-top:20px;}
  .list { display: inline-block;width:100%; }
  .panel {
    width: 90%;
    height: 100px;
    margin-left: 5%;
    margin-top: 35px;
    margin-bottom: 35px;
    flex-direction: column;
    justify-content: center;
    border-width: 2px;
    border-style: solid;
    border-color: rgb(162, 217, 192);
    background-color: rgba(162, 217, 192, 0.2);
    box-sizing: content-box;
  }

</style>

<script>
import AppHeader from '../components/app-header.vue'
  export default {
    components:{ AppHeader },
    data () {
      return {

        listData: [
          {
            text: '登录',
            name: 'login',
            url: '/LoginPage'
          },
          {
            text: '导航',
            name: 'navigator',
            url: '/navigator'
          },
          {
            text: '二维码',
            name: 'qrcode',
            url: '/qrcode'
          },
          {
            text: '相册',
            name: 'album',
            url: '/album'
          },{
            text: '本地存储',
            name: 'storage',
            url: '/storage'
          },{
            text: '获取当前用户信息',
            name: 'getUserInfo',
            url: '/userInfo'
          },{
            text: '网络类型切换提醒',
            name: 'changeNet',
            url: '/changeNet'
          },{
            text: '路由',
            name: 'router',
            url: '/router'
          },{
            text: '长列表滑动',
            name: 'longlist',
            url: '/longlist'
          },
        ]
      }
    }  
  }
</script>