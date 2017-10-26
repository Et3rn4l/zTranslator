import Vue from 'vue'
import Router from 'vue-router'
import synthesizeSpeech from '@/components/synthesizeSpeech'
import zTranlator from '@/components/zTranlator'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/translate',
      name: 'synthesizeSpeech',
      component: synthesizeSpeech
    },
    {
      path: '/',
      name: 'zTranlator',
      component: zTranlator
    }
  ]
})
