<template>
  <div class="wrapper">
    <app-header></app-header>
    <router-view style="flex:1"></router-view>
  </div>
</template>
<style>
.wrapper {
  align-items: center;
  height: 100%;
}

.text {
  font-size: 50px;
  text-align: center;
  color: #41B883;
}

.cnt {
  width: 100%;
}
</style>
<script>
import AppHeader from './components/app-header.vue'
export default {
  components: {
    AppHeader
  }
}
</script>
