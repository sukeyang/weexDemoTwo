<template>
  <div class="cnt">
    <text class="button" @click="jump(`/#/index`)">跳到app内部首页</text>
    <text class="button" @click="jump(`/#/router/taobao`)">跳到app外部页面</text>
  </div>  
</template>

<script>
  var navigator = weex.requireModule('navigator')
  var modal = weex.requireModule('modal')
  
  export default {
    methods: {
      jump (url) {
        navigator.push({
          url: url,
          animated: "false"
        })
      }
    }
  };
</script>
<style scoped>
  .cnt {
    min-height: 100%;
  }
  .button {
    margin: 30px auto;
    font-size: 60px;
    width: 90%;
    text-align: center;
    padding-top: 20px;
    padding-bottom: 20px;
    border-width: 2px;
    border-style: solid;
    color: #666666;
    border-color: #DDDDDD;
    background-color: #F5F5F5
  }
</style>