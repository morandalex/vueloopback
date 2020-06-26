import Vue from 'vue'
import './plugins/axios'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import router from './router'

Vue.config.productionTip = false
Vue.prototype.$hostname = (Vue.config.productionTip) ? 'https://endpoint1.morandi.services/api' : 'http://localhost:3000'

//localStorage['TOKENstate'] = 0;
new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
