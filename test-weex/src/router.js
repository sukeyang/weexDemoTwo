import Router from 'vue-router'
import LoginPage from './views/login-page.vue'
import index from './views/index.vue'
import longlist from './views/longlist.vue'
import storage from './views/storage.vue'
import router from './views/router.vue'
import routerTaobao from './views/router-taobao.vue'
import changeNet from './views/change-net.vue'

Vue.use(Router)

export default new Router({
  // mode: 'abstract',
  routes: [
    { path: '/index' , component:index },  
    { path: '/loginPage' , component:LoginPage },
    { path: '/longlist' , component:longlist },
    { path: '/storage' , component:storage },
    { path: '/router' , component:router },
    { path: '/router/taobao' , component:routerTaobao },
    { path: '/changeNet' , component:changeNet },
    { path: '/', redirect: '/index' }
  ]
})
