<template>
  <div class="cnt">
    <input placeholder="edit me" autofocus="true" v-model="message">
    <text>Message is: {{ message }}</text>
  </div>
</template>


<script>
  export default {
    data () {
      return {
        message: ''
      }
    }
  }
</script>